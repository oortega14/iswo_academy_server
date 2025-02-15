module Users
  # Define Registrations Controller
  class RegistrationsController < Devise::RegistrationsController
    # Responders
    respond_to :json

    # skips
    # skip_before_action :set_current_academy

    # POST '/api/v1/users'
    def create
      build_resource(sign_up_params)

      # Asignar una contraseña genérica
      resource.password = Rails.application.credentials.super_admin_password
      resource.password_confirmation = Rails.application.credentials.super_admin_password

      resource.save
      respond_with resource
    end

    def sign_up_params
      params.require(:user).permit(:email,
                                   :password,
                                   :password_confirmation,
                                   user_detail_attributes: [:first_name, :last_name])
    end

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed
    end

    def register_success
      render json: {
        message: 'Signed up succesfully.',
        user: resource
      }, status: :ok
    end

    def register_failed
      errors = []
      resource.errors.each do |error|
        errors << "#{error.attribute} #{error.message}"
      end
      raise ApiExceptions::BaseException.new(:FAILED_REGISTRATION, [errors], {})
    end
  end
end
