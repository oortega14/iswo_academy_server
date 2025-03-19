module Api
  module V1
    module Users
      # Define Passwords Controller
      class PasswordsController < Devise::PasswordsController
        # Responders
        respond_to :json

        # Método para procesar la solicitud de cambio de contraseña
        def create
          self.resource = resource_class.send_reset_password_instructions(resource_params)

          if successfully_sent?(resource)
            render json: { message: 'Las instrucciones de recuperación han sido enviadas a tu correo' }, status: :ok
          else
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # Método para actualizar la contraseña
        def update
          self.resource = resource_class.reset_password_by_token(resource_params)

          if resource.errors.empty?
            render json: { message: 'Contraseña actualizada exitosamente' }, status: :ok
          else
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def resource_params
          params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
        end
      end
    end
  end
end
