require_relative 'boot'
require_relative '../app/lib/middleware/subdomain_middleware'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IswoAcademyBack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2
    config.action_dispatch.cookies_same_site_protection = :lax
    config.api_only = true
    # config.middleware.use Middleware::SubdomainMiddleware
    config.i18n.available_locales = %i[es en]
    config.i18n.default_locale = :es
    config.i18n.fallbacks = { es: :en }
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths
    config.time_zone = 'America/Bogota'

    config.generators do |g|
      g.test_framework false
      g.model_specs true
      g.helper_specs false
      g.controller_specs true
    end
  end
end
