module Api
  module V1
    module Users
      # Define sessions controller for login
      class SessionsController < Devise::SessionsController
        # include Devise::JWT::Controllers::JwtHelper
        include RackSessionsFix
        include ActionController::Cookies
        include ActionController::RequestForgeryProtection

        respond_to :json

        skip_before_action :authenticate_user_from_token!

        def create
          user = find_user

          if user && authenticate_user(user)
            sign_in(user)
            access_token = JwtService.encode({ sub: user.id })
            refresh_token = create_refresh_token(user)

            render json: {
              user: serialize_item(user, UserSerializer),
              access_token: access_token,
              refresh_token: refresh_token.token
            }, status: :created
          else
            render_invalid_credentials
          end
        rescue Warden::AuthenticationError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end

        def destroy
          # Revocar el refresh token
          if params[:refresh_token]
            RefreshToken.find_by(token: params[:refresh_token])&.destroy
          end

          sign_out(current_user)
          render json: { message: 'Logged out successfully' }, status: :ok
        end

        private

        def find_user
          User.find_by(email: params[:user][:email])
        end

        def authenticate_user(user)
          user.valid_password?(params[:user][:password])
        end

        def create_refresh_token(user)
          user.refresh_tokens.create!(
            user_agent: request.user_agent,
            ip_address: request.remote_ip
          )
        end

        def render_invalid_credentials
          render json: { error: I18n.t('devise.failure.invalid', authentication_keys: 'Email') }, status: :unauthorized
        end

        def respond_with(_resource, _opts = {})
          render json: {
            message: 'You are logged in',
            user: ActiveModelSerializers::SerializableResource.new(
              current_user,
              serializer: UserSerializer
            ).as_json
          }, status: :ok
        end

        def respond_to_on_destroy
          log_out_success && return if current_user

          log_out_failure
        end

        def log_out_success
          render json: { message: 'You are logged out' }, status: :ok
        end

        def log_out_failure
          render json: { message: 'Hmm nothing happened' }, status: :unauthorized
        end
      end
    end
  end
end
