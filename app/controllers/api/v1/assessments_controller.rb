module Api
  module V1
    class AssessmentsController < BaseController
      # Before Actions
      before_action :set_assessment, only: %i[show update destroy]

      # GET '/api/v1/assessments'
      def index
        assessments = Assessment.all
        render json: assessments, status: :ok
      end

      # GET '/api/v1/assessments/:id'
      def show
        render_with(@assessment, context: { view: view_param })
      end

      # POST '/api/v1/assessments'
      def create
        assessment = Assessment.new(assessment_params)
        if assessment.save
          render json: assessment, status: :created
        else
          render json: { errors: assessment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH '/api/v1/academies/:id'
      def update
        authorize @assessment
        if @assessment.update(assessment_params)
          render json: @assessment, status: :ok
        else
          render json: { errors: @assessment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE '/api/v1/academies/:id'
      def destroy
        @assessment.destroy
        render json: { message: I18n.t('record.destroy.success') }, status: :ok
      end

      private

      def set_assessment
        @assessment = Assessment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Evaluación no encontrada' }, status: :not_found
      end

      def assessment_params
        params.require(:assessment).permit(
          :name,
          :description,
          :category_id,
          :slogan,
          :logo,
          :banner,
          academy_configuration_attributes: %i[
            id
            domain
            contact_email
            contact_phone
            contact_name
            color_palette
            _destroy
          ]
        )
      end

      def view_param
        params[:view]&.to_sym
      end
    end
  end
end
