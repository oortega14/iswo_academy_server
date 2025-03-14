# Filters Folder
module CustomFilters
  # Define a filter by evaluation
  class EvaluationFilter
    def filter(records, params)
      records = records.where(assessment_id: params[:final_exam_id]) if params[:final_exam_id].present?

      records
    end
  end
end
