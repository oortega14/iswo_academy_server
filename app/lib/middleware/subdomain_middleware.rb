module Middleware
  class SubdomainMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      excluded_paths = ['/api/v1/users']
      if excluded_paths.any? { |path| request.path.start_with?(path) }
        Rails.logger.info("Ruta excluida: #{request.path}")
        return @app.call(env)
      end

      domain = request.path.split('/')[1]
      academy = AcademyConfiguration.find_by(domain: domain)&.academy

      if academy.nil?
        # Manejo de error si la academia no se encuentra
        Rails.logger.error("Academia no encontrada para el dominio: #{domain}")
        # Podrías redirigir a una página de error o tomar otra acción
        return [404, { 'Content-Type' => 'text/plain' }, ['Academia no encontrada']]
      end

      env['current_academy'] = academy
      @app.call(env)
    end
  end
end
