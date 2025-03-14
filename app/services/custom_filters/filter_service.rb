# Filters Folder
module CustomFilters
  # Define a Service for filtering
  class FilterService < ApplicationService
    ACADEMY_FILTERABLE_MODELS = [Course].freeze
    COURSE_FILTERABLE_MODELS = [
      CourseSection,
      TeacherTask,
      CertificateConfiguration,
      Enrollment,
      FinalExam
    ].freeze
    COURSE_SECTION_FILTERABLE_MODELS = [Lesson, Quiz].freeze
    LESSON_FILTERABLE_MODELS = [Comment].freeze
    QUIZ_FILTERABLE_MODELS = [Question].freeze
    EVALUATION_FILTERABLE_MODELS = [Question].freeze
    QUESTION_FILTERABLE_MODELS = [QuestionOption, CorrectAnswer].freeze

    def initialize(records, params)
      super()
      @records = records
      @params = params
      @academy_filter = AcademyFilter.new
      @course_filter = CourseFilter.new
      @course_section_filter = CourseSectionFilter.new
      @lesson_filter = LessonFilter.new
      @quiz_filter = QuizFilter.new
      @question_filter = QuestionFilter.new
      @evaluation_filter = EvaluationFilter.new
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
      if COURSE_SECTION_FILTERABLE_MODELS.include?(@records.klass)
        @records = @course_section_filter.filter(@records, @params)
      end
      if QUIZ_FILTERABLE_MODELS.include?(@records.klass)
        @records = @quiz_filter.filter(@records, @params)
      end
      if QUESTION_FILTERABLE_MODELS.include?(@records.klass)
        @records = @question_filter.filter(@records, @params)
      end
      if EVALUATION_FILTERABLE_MODELS.include?(@records.klass)
        @records = @evaluation_filter.filter(@records, @params)
      end
    end
  end
end
