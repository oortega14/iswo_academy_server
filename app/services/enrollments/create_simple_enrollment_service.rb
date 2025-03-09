module Enrollments
  # Define Service for simple creation
  class CreateSimpleEnrollmentService < ApplicationService
    attr_reader :course_id, :errors, :enrollment, :academy_id

    def initialize(params)
      super()
      @enrollment = params[:enrollment]
      @course_id = params[:enrollment][:course_id]
      @academy_id = params[:enrollment][:academy_id]
      @errors = []
    end

    def call
      user = initialize_user
      if user.save
        assign_role(user)
        verify_student(user)
      else
        errors << { email: @enrollment[:email], errors: user.errors.full_messages }
      end
    rescue StandardError => e
      errors << { email: @enrollment[:email], errors: ["Error al procesar la inscripción: #{e.message}"] }
    end

    private

    def initialize_user
      user = User.find_or_initialize_by(email: @enrollment[:email])
      user.password ||= Rails.application.credentials.super_admin_password
      user.build_user_detail if user.user_detail.nil?
      user.user_detail.assign_attributes(user_detail_params)
      user
    end

    def user_detail_params
      @enrollment.permit(:first_name, :last_name, :dni)
    end

    def assign_role(user)
      user_academy = UserAcademy.find_or_initialize_by(user_id: user.id, academy_id: @academy_id)
      user_academy.role ||= 'student'
      user_academy.save!
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
