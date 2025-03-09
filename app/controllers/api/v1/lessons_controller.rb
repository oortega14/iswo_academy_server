module Api
  module V1
    class LessonsController < ApplicationController
      # Callbacks
      before_action :set_lesson, only: %i[show update destroy update_section update_visibility move_up move_down]

      # GET: '/api/lessons'
      def index
        lessons = policy_scope(Lesson)
        filtered_lessons = CustomFilters::FilterService.call(lessons, params).order(:position)

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

      # PATCH: '/api/v1/academies/:academy_id/courses/:course_id/course_sections/:course_section_id/lessons/:id/update_visibility'
      def update_visibility
        authorize @lesson

        @lesson.toggle!(:visible)
        render json: { message: I18n.t('record.update.success') }, status: :ok
      end

      # POST '/api/v1/academies/:academy_id/courses/:course_id/course_sections/:course_section_id/lessons/:id/move_up'
      def move_up
        authorize @lesson

        if @lesson.first?
          raise ApiExceptions::BaseException.new(:ALREADY_FIRST, [], {})
        else
          @lesson.move_higher
          render json: { message: I18n.t('record.update.success') }, status: :ok
        end
      end

      # POST '/api/v1/academies/:academy_id/courses/:course_id/course_sections/:course_section_id/lessons/:id/move_down'
      def move_down
        authorize @lesson

        if @lesson.last?
          raise ApiExceptions::BaseException.new(:ALREADY_LAST, [], {})
        else
          @lesson.move_lower
          render json: { message: I18n.t('record.update.success') }, status: :ok
        end
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
