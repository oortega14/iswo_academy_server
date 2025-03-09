module Api
  module V1
    class LessonsController < ApplicationController
      # Callbacks
      before_action :set_lesson, only: %i[show update destroy update_section update_visibility]

      # GET: '/api/lessons'
      def index
        lessons = policy_scope(Lesson)
        filtered_lessons = CustomFilters::FilterService.call(lessons, params)

        render_with(filtered_lessons)
      end

      # GET: '/api/lessons/:id'
      def show
        authorize @lesson

        render_with(@lesson)
      end

      # POST: '/api/lessons'
      def create
        lesson = Lesson.new(lesson_params)
        authorize lesson

        render_with(lesson)
      end

      # PATCH: '/api/lessons/:id'
      def update
        authorize @lesson

        @lesson.video.purge if params[:lesson][:remove_video].present?
        @lesson.update(lesson_params)
        render_with(@lesson)
      end

      # DELETE: '/api/lessons/:id'
      def destroy
        authorize @lesson

        render_with(@lesson)
      end

      # PATCH: '/api/lessons/:id/update_visibility'
      def update_visibility
        authorize @lesson

        @lesson.update!(visible: params[:visible])
        render json: { message: I18n.t('record.update.success') }, status: :ok
      end

      # PATCH: '/api/lessons/:id/update_position'
      def update_position
        Lessons::LessonPositionUpdater.new(params[:sorted_lessons], current_user).call

        render json: { message: I18n.t('record.update.success') }, status: :ok
      end

      private

      # Strong params
      def lesson_params
        params.require(:lesson).permit(:title,
                                       :description,
                                       :course_section_id,
                                       :visible,
                                       attachments_attributes: %i[id file attachable_id attachable_type category type url _destroy])
      end

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end
    end
  end
end
