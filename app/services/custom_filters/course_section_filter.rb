# Filters Folder
module CustomFilters
  # Define a filter by course_section
  class CourseSectionFilter
    def filter(records, params)
      records = records.where(course_section_id: params[:course_section_id]) if params[:course_section_id].present?

      records
    end
  end
end
