module Api
  module V1
    class SubscriptionsController < BaseController
      before_action :set_subscription, only: [:show]

      def index
        @subscriptions = current_user.subscriptions
        render json: @subscriptions
      end

      def show
        render json: @subscription
      end

      def create
        subscription = Subscription.new(subscription_params)
        if subscription.save
          render json: subscription, status: :created
        else
          render json: subscription.errors, status: :unprocessable_entity
        end
      end

      private

      def set_subscription
        @subscription = current_user.subscriptionzes.find(params[:id])
      end

      def subscription_params
        params.require(:subscription).permit(:academy_id, :user_id, :status)
      end
    end
  end
end
