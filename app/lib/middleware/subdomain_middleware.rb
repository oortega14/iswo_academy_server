module Middleware
  class SubdomainMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      excluded_paths = ['/register', '/login', '/passwords', '/users/sign_in', '/users/sign_up', '/api/v1/users']
      return @app.call(env) if excluded_paths.any? { |path| request.path.start_with?(path) }

      domain = request.path.split('/')[1]
      academy = AcademyConfiguration.find_by(domain: domain)&.academy
      env['current_academy'] = academy

      @app.call(env)
    end
  end
end
