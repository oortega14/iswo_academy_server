class ApplicationController < ActionController::API
  # include Pagy::Backend
  include Pundit::Authorization
  include ActionController::MimeResponds
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  # include JsonapiResponses::Respondable

  respond_to :json

  # Callbacks
  before_action :set_locale
  before_action :set_current_academy

  # Rescues
  rescue_from ApiExceptions::BaseException, with: :render_error_response
  rescue_from Pundit::NotAuthorizedError, with: :handle_user_not_authorized
  rescue_from JWT::ExpiredSignature, with: :handle_expired_jwt

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
    current_api_user
  end

  def handle_user_not_authorized
    render_error_response(ApiExceptions::BaseException.new(:UNAUTHORIZED, [], {}))
  end

  def handle_expired_jwt
    render json: { message: I18n.t('jwt.expired_signature'), expired: true }, status: :unauthorized
    # cookies.delete(:jwt)
  end

  def set_current_academy
    @current_academy = request.env['current_academy']
    render json: { error: 'Academia no encontrada' }, status: :not_found unless @current_academy
  end
end
