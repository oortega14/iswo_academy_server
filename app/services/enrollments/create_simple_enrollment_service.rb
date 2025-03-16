module Enrollments
  # Define Service for simple creation
  class CreateSimpleEnrollmentService < ApplicationService
    attr_reader :course_id, :errors, :enrollment, :academy_id, :email

    def initialize(params)
      super()
      @enrollment = params[:enrollment]
      @course_id = @enrollment[:course_id]
      @academy_id = @enrollment[:academy_id]
      @email = @enrollment[:email]
      @errors = []
    end

    def call
      user = initialize_user
      if user.save
        assign_role(user)
        verify_student(user)
      else
        errors << { email: @email, errors: user.errors.full_messages }
      end
      errors.empty?
    rescue StandardError => e
      errors << { email: @email, errors: ["Error al procesar la inscripción: #{e.message}"] }
      errors.empty?
    end

    private

    def user_detail_params
      @enrollment.permit(:first_name, :last_name, :dni)
    end

    def initialize_user
      user = User.find_or_initialize_by(email: @email)
      user.password ||= Rails.application.credentials.super_admin_password
      user.build_user_detail if user.user_detail.nil?
      user.user_detail.assign_attributes(user_detail_params)
      user
    end

    def assign_role(user)
      user_academy = UserAcademy.find_by(user_id: user.id, academy_id: @academy_id)

      if user_academy.nil?
        UserAcademy.create!(
          user_id: user.id,
          academy_id: @academy_id,
          role: 'student'
        )
        user.update(is_profile_completed: true)
      elsif user_academy.role == 'admin'
        UserAcademy.create!(
          user_id: user.id,
          academy_id: @academy_id,
          role: 'student'
        )
        user.update(is_profile_completed: true)
      end
    end

    def verify_student(user)
      Enrollment.find_or_create_by!(user_id: user.id, course_id: @course_id) do |enrollment_record|
        enrollment_record.status = 'purchased'
        enrollment_record.progress = 'not_started'
        enrollment_record.purchased_at = Time.current
      end
    end
  end
end
