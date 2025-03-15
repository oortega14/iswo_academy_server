module Api
  module V1
    class CertificateConfigurationsController < BaseController
      before_action :set_certificate_configuration, only: [:show, :update, :destroy]

      def index
        certificate_configurations = policy_scope(CertificateConfiguration)
        render_with(certificate_configurations)
      end

      def show
        render_with(@certificate_configuration)
      end

      def create
        certificate_configuration = CertificateConfiguration.new(certificate_configuration_params)
        authorize certificate_configuration

        render_with(certificate_configuration)
      end

      def update
        @certificate_configuration.update!(certificate_configuration_params)
        render json: @certificate_configuration, serializer: CertificateConfigurationSerializer
      end

      def destroy
        @certificate_configuration.destroy!
        render json: { message: 'Certificate configuration deleted successfully' }
      end

      private

      def set_certificate_configuration
        @certificate_configuration = CertificateConfiguration.find(params[:id])
      end

      def certificate_configuration_params
        params.require(:certificate_configuration).permit(:course_id, :certificate_template, :course_name, :course_time)
      end
    end
  end
end
