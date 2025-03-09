module Enrollments
  # Define Service for multiple creation
  class CreateMultipleEnrollmentsService < ApplicationService
    attr_reader :file, :academy_id, :course_id, :errors

    def initialize(params)
      super()
      @file = params[:file]&.path
      @academy_id = params[:academy_id]
      @course_id = params[:course_id]
      @errors = []
    end

    def call
      return unless @file

      begin
        spreadsheet = Roo::Spreadsheet.open(file)
        header = map_headers(spreadsheet.row(1))

        (2..spreadsheet.last_row).each do |i|
          enrollment_data = prepare_enrollment_data(header, spreadsheet.row(i))
          process_enrollment(enrollment_data)
        end
      rescue StandardError => e
        errors << { error: e.message }
      end
      errors.empty?
    end

    private

    def prepare_enrollment_data(header, row)
      enrollment_data = header.zip(row).to_h
      {
        email: sanitize_text(enrollment_data['email']),
        first_name: sanitize_text(enrollment_data['first_name']),
        last_name: sanitize_text(enrollment_data['last_name']),
        dni: sanitize_text(enrollment_data['dni'])
      }
    end

    def process_enrollment(enrollment_data)
      user = initialize_user(enrollment_data)
      if user.save
        assign_role(user)
        verify_student(user)
      else
        errors << { email: enrollment_data[:email], errors: user.errors.full_messages }
      end
    rescue StandardError => e
      errors << { email: enrollment_data[:email], errors: ["Error al procesar la inscripción: #{e.message}"] }
    end

    def initialize_user(enrollment_data)
      user = User.find_or_initialize_by(email: enrollment_data[:email])
      user.password ||= Rails.application.credentials.super_admin_password
      user.build_user_detail if user.user_detail.nil?
      user.user_detail.assign_attributes(enrollment_data.except(:email))
      user
    end

    def assign_role(user)
      user_academy = UserAcademy.find_or_initialize_by(user_id: user.id, academy_id: academy_id)
      user_academy.role ||= 'student'
      user_academy.save!
    end

    def verify_student(user)
      Enrollment.find_or_create_by!(user_id: user.id, course_id: course_id) do |enrollment_record|
        enrollment_record.status = 'purchased'
        enrollment_record.progress = 'not_started'
        enrollment_record.purchased_at = Time.current
      end
    end

    def map_headers(headers)
      header_mapping = {
        'first_name' => ['first_name', 'first name', 'nombres', 'Nombres'],
        'last_name' => ['last_name', 'last name', 'apellidos', 'Apellidos'],
        'email' => ['email', 'correo', 'correo electronico', 'Correo electronico', 'Correo eléctronico']
      }

      headers.map do |header|
        normalized = I18n.transliterate(header.to_s).downcase.strip.gsub(/\s+/, ' ')
        mapped = header_mapping.find { |key, values| values.map { |v| I18n.transliterate(v).downcase.strip }.include?(normalized) }
        mapped ? mapped[0] : normalized
      end
    end

    def sanitize_text(text)
      return nil if text.nil?

      # Opción 1: Usando expresiones regulares
      text.to_s.gsub(/<[^>]*>/, '').strip

      # Opción 2: Usando ActionView::Helpers::SanitizeHelper
      # ActionView::Base.full_sanitizer.sanitize(text.to_s).strip
    end
  end
end
