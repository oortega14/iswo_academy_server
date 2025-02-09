require 'mercadopago'

class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user!
  
  def create_admin_subscription
    return render json: { error: "Solo los usuarios normales pueden registrarse como admins" }, status: :unprocessable_entity if current_user.admin?

    preference_data = {
      items: [{
        title: "Suscripción Anual - Academia",
        quantity: 1,
        unit_price: 100.0,
        currency_id: "USD"
      }],
      payer: {
        email: current_user.email
      },
      back_urls: {
        success: "#{ENV.fetch('FRONTEND_URL')}/payment/success",
        failure: "#{ENV.fetch('FRONTEND_URL')}/payment/failure"
      },
      auto_return: "approved"
    }

    preference = MercadoPago::Preference.new(preference_data)
    preference.save

    subscription = Subscription.create!(user: current_user, amount: 100.0, status: :pending)

    render json: { url: preference.init_point, subscription_id: subscription.id }
  end

  def webhook
    payment = MercadoPago::Payment.find(params[:data][:id])
    subscription = Subscription.find_by(id: params[:external_reference])
  
    if payment.status == "approved"
      subscription.update!(status: :paid)
      subscription.user.update!(role: :admin)
      render json: { success: true }, status: :ok
    else
      subscription.update!(status: :failed)
      render json: { success: false }, status: :unprocessable_entity
    end
  end
  
  def purchase_course
    course = Course.find(params[:course_id])
    admin = course.academy.admin
    price = course.price
    fee = price * 0.10 # Retención del 10%
    admin_amount = price - fee
  
    preference_data = {
      items: [{
        title: course.title,
        quantity: 1,
        unit_price: price,
        currency_id: "USD"
      }],
      payer: {
        email: current_user.email
      },
      payment_methods: {
        excluded_payment_types: [{ id: "ticket" }]
      },
      back_urls: {
        success: "#{frontend_url}/payment/success",
        failure: "#{frontend_url}/payment/failure"
      },
      auto_return: "approved",
      notification_url: "#{backend_url}/api/v1/payments/webhook",
      external_reference: course.id.to_s
    }
  
    preference = MercadoPago::Preference.new(preference_data)
    preference.save
  
    CoursePurchase.create!(user: current_user, course: course, amount: price, status: :pending)
  
    render json: { url: preference.init_point }
  end

  def course_webhook
    payment = MercadoPago::Payment.find(params[:data][:id])
    purchase = CoursePurchase.find_by(id: params[:external_reference])
  
    if payment.status == "approved"
      purchase.update!(status: :paid)
  
      # Transferencia de dinero al administrador
      MercadoPago::Payment.create(
        transaction_amount: purchase.amount * 0.90, # 90% al admin
        payer: { email: "TU_EMAIL_MERCADOPAGO" },
        collector: { email: purchase.course.academy.admin.email }
      )
  
      render json: { success: true }, status: :ok
    else
      purchase.update!(status: :failed)
      render json: { success: false }, status: :unprocessable_entity
    end
  end  
end
