module Users
  # Define sessions controller for login
  class SessionsController < Devise::SessionsController
    # include Devise::JWT::Controllers::JwtHelper
    include RackSessionsFix
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection

    # Callbacks
    before_action :authenticate!, except: %i[destroy create]
    skip_before_action :verify_signed_out_user, only: [:destroy]
    skip_before_action :set_current_academy

    respond_to :json

    def create
      user = find_user

      if user && authenticate_user(user)
        handle_successful_login(user)
      else
        render_invalid_credentials
      end
    end

    def destroy
      cookies.delete(:jwt)
      render json: { message: 'Logged out successfully' }, status: :ok
    end

    private

    def find_user
      User.find_by(email: params[:user][:email])
    end

    def authenticate_user(user)
      user.valid_password?(params[:user][:password])
    end

    def handle_successful_login(user)
      sign_in(user)
      token = current_token(user)
      create_jwt_cookie(token)

      render json: {
        user: user.as_json
      }, status: :created
    end

    def create_jwt_cookie(token)
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        expires: 2.days.from_now
      }
    end

    def render_invalid_credentials
      render json: { error: I18n.t('devise.failure.invalid', authentication_keys: 'Email') }, status: :unauthorized
    end

    def respond_with(_resource, _opts = {})
      render json: {
        message: 'You are logged in',
        user: ActiveModelSerializers::SerializableResource.new(
          current_api_user,
          serializer: UserSerializer
        ).as_json
      }, status: :ok
    end

    def respond_to_on_destroy
      log_out_success && return if current_api_user

      log_out_failure
    end

    def log_out_success
      render json: { message: 'You are logged out' }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Hmm nothing happened' }, status: :unauthorized
    end

    def current_token(user)
      Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    end
  end
end
