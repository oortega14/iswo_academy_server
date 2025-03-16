module Courses
  class PublishService
    attr_reader :course, :errors

    def initialize(course)
      @course = course
      @errors = []
    end

    def valid_for_publishing?
      @errors = []

      validate_final_exam
      validate_sections_and_lessons
      validate_certificate_configuration

      @errors.empty?
    end

    private

    def validate_final_exam
      unless course.final_exam.present?
        @errors << 'El curso debe tener un examen final configurado'
      end
    end

    def validate_sections_and_lessons
      if course.course_sections.empty?
        @errors << 'El curso debe tener al menos una sección'
        return
      end

      has_lessons = course.course_sections.any? { |section| section.lessons.present? }

      unless has_lessons
        @errors << 'El curso debe tener al menos una clase en alguna de sus secciones'
      end
    end

    def validate_certificate_configuration
      unless course.certificate_configuration.present?
        @errors << 'El curso debe tener una configuración de certificado'
      end
    end
  end
end
