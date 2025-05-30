class ApplicationController < ActionController::API
  # include Pagy::Backend
  include Pundit::Authorization
  include ActionController::MimeResponds
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include Devise::JWT::RevocationStrategies::Denylist
  include JsonapiResponses::Respondable

  respond_to :json

  # Callbacks
  before_action :set_locale
  # before_action :set_current_academy
  before_action :authenticate_user_from_token!

  # Rescues
  rescue_from ApiExceptions::BaseException, with: :render_error_response
  rescue_from Pundit::NotAuthorizedError, with: :handle_user_not_authorized
  rescue_from JWT::ExpiredSignature, with: :handle_expired_jwt
  rescue_from JWT::DecodeError, with: :handle_expired_jwt

  def render_error_response(error)
    error_response = {
      error: {
        code: error.code,
        messages: error.messages
      }
    }
    render json: error_response, status: 502
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_user
    @current_user
  end

  def current_academy
    @current_academy ||= current_user&.active_academy
  end

  def user_signed_in?
    current_user.present?
  end

  def handle_user_not_authorized
    render_error_response(ApiExceptions::BaseException.new(:UNAUTHORIZED, [], {}))
  end

  def handle_expired_jwt
    render json: { message: I18n.t('jwt.expired_signature'), expired: true }, status: :unauthorized
  end

  def handle_decode_error
    render json: { message: I18n.t('jwt.decode_error'), expired: true }, status: :unprocessable_entity
  end

  def set_current_academy
    @current_academy = request.env['current_academy']
    render json: { error: 'Academia no encontrada' }, status: :not_found unless @current_academy
  end

  private

  def find_user_from_token(token)
    decoded_token = Warden::JWTAuth::TokenDecoder.new.call(token)
    User.find(decoded_token['sub'])
  end

  def token_from_request
    request.headers['Authorization']&.split(' ')&.last ||
    cookies.signed[:jwt]
  end

  def authenticate_user_from_token!
    header = request.headers['Authorization']
    if header.present?
      token = header.split(' ').last
      payload = JwtService.decode(token)
      if payload && payload[:sub]
        @current_user = User.find_by(id: payload[:sub])
      end
    end
  end
end
