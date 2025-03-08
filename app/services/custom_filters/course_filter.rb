# Filters Folder
module CustomFilters
  # Define a filter by course
  class CourseFilter
    def filter(records, params)
      records = records.where(course_id: params[:course_id]) if params[:course_id].present?

      records
    end
  end
end
