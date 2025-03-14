module Api::V1
  class QuestionsController < BaseController
    before_action :set_question, only: [:show, :update, :destroy]

    def index
      questions = Question.all
      filtered_questions = CustomFilters::FilterService.call(questions, params)
      render_with(filtered_questions)
    end

    def show
      render_with(@question)
    end

    def create
      question = Question.new(question_params)
      render_with(question)
    end

    def update
      @question.update(question_params)
      render_with(@question)
    end

    def destroy
      @question.destroy
      render json: { message: 'Question deleted successfully' }
    end

    private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(
        :content,
        :question_type,
        :assessment_id,
        :position,
        question_options_attributes: [:id, :content, :correct, :position, :_destroy],
        correct_answer_attributes: [:id, :content, :_destroy]
      )
    end
  end
end
