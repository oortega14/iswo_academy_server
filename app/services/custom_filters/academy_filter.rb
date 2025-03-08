# Filters Folder
module CustomFilters
  # A filter by academy
  class AcademyFilter
    def filter(records, params)
      records = records.where(academy_id: params[:academy_id]) if params[:academy_id].present?

      records
    end
  end
end
