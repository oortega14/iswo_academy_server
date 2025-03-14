# Filters Folder
module CustomFilters
  # Define a filter by question
  class QuestionFilter
    def filter(records, params)
      records = records.where(question_id: params[:question_id]) if params[:question_id].present?

      records
    end
  end
end
