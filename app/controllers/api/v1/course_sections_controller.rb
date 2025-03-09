module Api
  module V1
    class CourseSectionsController < BaseController
      before_action :set_section, only: %i[update destroy show move_down move_up]

    # GET '/api/course_sections'
    def index
      sections = current_user ? policy_scope(CourseSection) : CourseSection.all
      filtered_sections = CustomFilters::FilterService.call(sections, params).order(:position)
      render_with(filtered_sections, context: { view: view_param })
    end

    # GET '/api/course_sections/:id'
    def show
      authorize @section

      render_with(@section, context: { view: :summary })
    end

    # POST '/api/course_sections'
    def create
      section = CourseSection.new(section_params)
      authorize section

      render_with(section, context: { view: :summary })
    end

    # PATCH '/api/course_sections/:id'
    def update
      authorize @section

      @section.update(section_params)
      render_with(@section, context: { view: :summary })
    end

    # DELETE '/api/course_sections/:id'
    def destroy
      authorize @section

      render_with(@section)
    end

    # POST '/api/v1/academies/:academy_id/courses/:course_id/course_sections/:id/move_up'
    def move_up
      authorize @section

      if @section.first?
        raise ApiExceptions::BaseException.new(:ALREADY_FIRST, [], {})
      else
        @section.move_higher
        render json: { message: I18n.t('record.update.success') }, status: :ok
      end
    end

    # POST '/api/v1/academies/:academy_id/courses/:course_id/course_sections/:id/move_down'
    def move_down
      authorize @section

      if @section.last?
        raise ApiExceptions::BaseException.new(:ALREADY_LAST, [], {})
      else
        @section.move_lower
        render json: { message: I18n.t('record.update.success') }, status: :ok
      end
    end

    private

    def set_section
      @section = CourseSection.find(params[:id])
    end

    # Strong params
    def section_params
      params.require(:course_section).permit(:name, :position, :course_id)
    end

    def view_param
      params[:view]&.to_sym
    end
    end
  end
end
