module Api
  module V1
    class StudentQuizzesController < BaseController
      before_action :set_student_quiz, only: [:show, :start, :submit]

      def index
        @quizzes = current_user.student_quizzes.includes(:assessment)
        render json: @quizzes
      end

      def show
        render json: @student_quiz
      end

      def start
        if @student_quiz.can_attempt?
          @student_quiz.register_attempt
          render json: { message: 'Intento registrado', quiz: @student_quiz }
        else
          render json: { error: 'No puedes intentar el quiz todavía' }, status: :forbidden
        end
      end

      def submit
        score = calculate_score(params[:responses])
        @student_quiz.update!(score: score, status: :completed)

        render json: { message: 'Quiz enviado', score: score, passed: @student_quiz.passed? }
      end

      private

      def set_student_quiz
        @student_quiz = current_user.student_quizzes.find(params[:id])
      end

      def calculate_score(responses)
        correct_answers = 0

        responses.each do |response|
          question = Question.find(response[:question_id])
          correct_answers += 1 if question.correct_answer == response[:answer]
        end

        (correct_answers.to_f / responses.size * 100).round
      end
    end
  end
end
