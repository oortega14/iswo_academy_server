module Api
  module V1
    # Define Confirmations controller
    class ConfirmationsController < Devise::ConfirmationsController
      def create
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
        if resource.errors.empty?
          render json: { message: 'Email confirmado exitosamente.' }, status: :ok
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
