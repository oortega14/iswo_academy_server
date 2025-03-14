module Api
  module V1
    class CoursesController < BaseController
      before_action :set_course, only: [:show, :update, :destroy]

      # GET /courses
      def index
        @courses = policy_scope(Course)
        render_with(@courses)
      end

      # POST /courses
      def create
        course = Course.new(course_params)
        course.creator = current_user
        authorize(course)

        course.save!
        render_with(course)
      end

      # GET /courses/:id
      def show
        @course = Course.find(params[:id])
        authorize(@course)

        render_with(@course, context: { view: view_param })
      end

      # PATCH /courses/:id
      def update
        authorize(@course)

        @course.update!(course_params)
        render_with(@course)
      end

      # DELETE /courses/:id
      def destroy
        authorize @course

        render_with(@course)
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(
          :title,
          :description,
          :price,
          :status,
          :academy_id,
          :banner,
          :promotional_image,
          course_benefits_attributes: [:id, :description, :_destroy],
          course_goals_attributes: [:id, :description, :_destroy],
          attachments_attributes: [
            :id,
            :type,
            :attachable_type,
            :attachable_id,
            :url,
            :file,
            :category,
            :_destroy
          ],
          learning_route_ids: []
        )
      end

      def view_param
        params[:view]&.to_sym
      end
    end
  end
end
