module Api
  module V1
    class StudentFinalExamsController < BaseController
      before_action :set_student_final_exam, only: [:show, :start, :submit]

      def index
        @final_exams = current_user.student_final_exams.includes(:assessment)
        render json: @final_exams
      end

      def show
        render json: @student_final_exam
      end

      def start
        if @student_final_exam.can_attempt?
          @student_final_exam.register_attempt
          render json: { message: 'Intento registrado', final_exam: @student_final_exam }
        else
          render json: { error: 'No puedes intentar el examen todavía' }, status: :forbidden
        end
      end

      def submit
        score = calculate_score(params[:responses])
        @student_final_exam.update!(score: score, status: :completed)

        render json: { message: 'Examen enviado', score: score, passed: @student_final_exam.passed? }
      end

      private

      def set_student_final_exam
        @student_final_exam = current_user.student_final_exams.find(params[:id])
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
