# Filters Folder
module CustomFilters
  # Define a filter by quiz
  class QuizFilter
    def filter(records, params)
      records = records.where(assessment_id: params[:quiz_id]) if params[:quiz_id].present?

      records
    end
  end
end
