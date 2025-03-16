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

  # Rescues
  rescue_from ApiExceptions::BaseException, with: :render_error_response
  rescue_from Pundit::NotAuthorizedError, with: :handle_user_not_authorized
  rescue_from JWT::ExpiredSignature, with: :handle_expired_jwt

  def authenticate!
    return render json: { error: 'Not authorized' }, status: :unauthorized unless token_from_request

    begin
      @current_user = find_user_from_token(token_from_request)
      sign_in(@current_user, store: false) if @current_user
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { error: 'Not authorized' }, status: :unauthorized
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def render_error_response(error)
    error_response = {
      error: {
        code: error.code,
        message: error.message,
        details: error.details
      }
    }
    render json: error_response, status: 502
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_user
    return @current_user if defined?(@current_user)

    return nil unless token_from_request.present?

    @current_user = find_user_from_token(token_from_request)
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
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
    # cookies.delete(:jwt)
  end

  def set_current_academy
    debugger
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
end
