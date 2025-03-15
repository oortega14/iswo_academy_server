module Api
  module V1
    class QuizzesController < BaseController
      before_action :set_quiz, only: [:show, :update, :destroy]

      def index
        @quizzes = Quiz.where(course_section_id: params[:course_section_id])
        render json: @quizzes
      end

      def show
        render_with(@quiz)
      end

      def create
        quiz = Quiz.new(quiz_params)
        quiz.teacher = current_user
        authorize quiz

        render_with(quiz)
      end

      def update
        if @quiz.update(quiz_params)
          render json: @quiz
        else
          render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @quiz.destroy
        render json: { message: 'Quiz deleted successfully' }
      end

      private

      def set_quiz
        @quiz = Quiz.find(params[:id])
      end

      def quiz_params
        params.require(:quiz).permit(:name, :time_limit, :approve_with, :max_attempts, :retry_after, :course_section_id, :course_id)
      end
    end
  end
end
