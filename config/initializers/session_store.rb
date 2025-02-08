if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_iswo_academy_session_id', domain: 'iswo-academy-json-api'
else
  Rails.application.config.session_store :cookie_store, key: '_iswo_academy_session_id', domain: :all, path: '/', secure: true, httponly: false
end
