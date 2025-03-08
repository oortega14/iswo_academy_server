# Filters Folder
module CustomFilters
  # Define a filter by lesson
  class LessonFilter
    def filter(records, params)
      records = records.where(lesson_id: params[:lesson_id]) if params[:lesson_id].present?

      records
    end
  end
end
