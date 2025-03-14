module Api
  module V1
    # Define CertificateConfiguration Controller
    class CertificateConfigurationsController < BaseController
      before_action :set_certificate_configuration, only: %i[show update destroy]

      # GET: '/api/certificate_configurations'
      def index
        certificate_configurations = policy_scope(CertificateConfiguration)
        filtered_configurations = CustomFilters::FilterService.call(certificate_configurations, params)
        render_with(filtered_configurations, context: { view: :summary })
      end

      # GET: '/api/certificate_configurations/:id'
      def show
        authorize @certificate_configuration

        render_with(@certificate_configuration)
      end

      # POST: '/api/certificate_configurations'
      def create
        certificate_configuration = CertificateConfiguration.new(certificate_configuration_params)
        authorize certificate_configuration

        render_with(certificate_configuration)
      end

      # PATCH: '/api/certificate_configurations/:id'
      def update
        authorize @certificate_configuration

        @certificate_configuration.update(certificate_configuration_params)
        render_with(@certificate_configuration)
      end

      # DELETE: '/api/certificate_configurations'
      def destroy
        authorize @certificate_configuration

        render_with(@certificate_configuration)
      end

      private

      # Strong params
      def certificate_configuration_params
        params.require(:certificate_configuration).permit(:course_id, :course_name, :course_time, :certificate_blueprint)
      end

      def set_certificate_configuration
        @certificate_configuration = CertificateConfiguration.find(params[:id])
      end
    end
  end
end
