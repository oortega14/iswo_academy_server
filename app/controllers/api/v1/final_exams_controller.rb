module Api
  module V1
    class FinalExamsController < BaseController
      before_action :set_final_exam, only: [:show, :update, :destroy]

      def index
        final_exams = policy_scope(FinalExam)
        filtered_final_exams = CustomFilters::FilterService.call(final_exams, params)
        render_with(filtered_final_exams)
      end

      def show
        render_with(@final_exam)
      end

      def create
        final_exam = FinalExam.new(final_exam_params)
        final_exam.teacher = current_user

        final_exam.save!
        render_with(final_exam)
      end

      def update
        if @final_exam.update(final_exam_params)
          render json: @final_exam
        else
          render json: { errors: @final_exam.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @final_exam.destroy
        head :no_content
      end

      private

      def set_final_exam
        @final_exam = FinalExam.find(params[:id])
      end

      def final_exam_params
        params.require(:final_exam).permit(
          :name,
          :max_attempts,
          :retry_after,
          :time_limit,
          :approve_with,
          :course_id
        )
      end
    end
  end
end
