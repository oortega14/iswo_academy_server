# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'no-reply@sigiswo.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.confirm_within = nil
  config.skip_session_storage = %i[http_auth token_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise[:jwt_secret_key]
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 1.days.to_i
  end
  config.navigational_formats = []
  config.skip_session_storage = [:http_auth, :params_auth]
end
