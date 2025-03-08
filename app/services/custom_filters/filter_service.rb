# Filters Folder
module CustomFilters
  # Define a Service for filtering
  class FilterService < ApplicationService
    ACADEMY_FILTERABLE_MODELS = [Course].freeze
    COURSE_FILTERABLE_MODELS = [
      CourseSection,
      TeacherTask,
      CertificateConfiguration
    ].freeze
    COURSE_SECTION_FILTERABLE_MODELS = [Lesson].freeze
    LESSON_FILTERABLE_MODELS = [Comment].freeze
    # TEST_QUESTION_FILTERABLE_MODELS = [QuestionOption].freeze

    def initialize(records, params)
      super()
      @records = records
      @params = params
      @academy_filter = AcademyFilter.new
      @course_filter = CourseFilter.new
      @lesson_filter = LessonFilter.new
      @course_section_filter = CourseSectionFilter.new
      # @test_question_filter = TestQuestionFilter.new
    end

    def call
      apply_filters
      @records
    end

    private

    def apply_filters
      @records = @academy_filter.filter(@records, @params) if ACADEMY_FILTERABLE_MODELS.include?(@records.klass)
      @records = @course_filter.filter(@records, @params) if COURSE_FILTERABLE_MODELS.include?(@records.klass)
      @records = @lesson_filter.filter(@records, @params) if LESSON_FILTERABLE_MODELS.include?(@records.klass)
      # if COURSE_SECTION_FILTERABLE_MODELS.include?(@records.klass)
      #   @records = @course_section_filter.filter(@records, @params)
      # end
      # return unless TEST_QUESTION_FILTERABLE_MODELS.include?(@records.klass)

      # @records = @test_question_filter.filter(@records, @params)
    end
  end
end
