module Api
  module V1
    class EnrollmentsController < BaseController
      before_action :set_enrollment, only: %i[show update destroy]

      # GET: '/api/v1/enrollments'
      def index
        enrollments = policy_scope(Enrollment)
        filtered_enrollments = CustomFilters::FilterService.call(enrollments, params)

        render_with(filtered_enrollments)
      end

      # GET: '/api/v1/enrollments/:id'
      def show
        render_with(@enrollment)
      end

      # POST: '/api/v1/enrollments'
      def create
        enrollment = Enrollment.new(enrollment_params)
        render_with(enrollment)
      end

      # PATCH: '/api/v1/enrollments/:id'
      def update
        enrollment = Enrollment.find(params[:id])
        enrollment.update(enrollment_params)
      end

      # DELETE: '/api/v1/enrollments/:id'
      def destroy
        enrollment = Enrollment.find(params[:id])
        enrollment.destroy
      end

      # POST: '/api/enrollments/create_simple'
      def create_simple
        service = Enrollments::CreateSimpleEnrollmentService.new(params)
        raise ApiExceptions::BaseException.new(:STUDENTS_NOT_CREATED, [service.errors], {}) unless service.call

        render json: { message: I18n.t('record.create.success') }, status: :created
      end

      # POST: '/api/enrollments/create_multiple'
      def create_multiple
        service = Enrollments::CreateMultipleEnrollmentsService.new(params)
        raise ApiExceptions::BaseException.new(:STUDENTS_NOT_CREATED, [service.errors], {}) unless service.call

        render json: { message: I18n.t('record.create.success') }, status: :created
      end

      # DELETE: '/api/enrollments/:id
      def destroy
        @enrollment.destroy
        render json: { message: I18n.t('record.destroy.success') }, status: :ok
      end

      # GET: '/api/v1/enrollments/purchased_courses'
      def purchased_courses
        enrollments = current_user.enrollments.where(status: 'purchased')
        purchased_courses = enrollments.map(&:course)
        render json: serialize_collection(purchased_courses, CourseSerializer), status: :ok
      end

      # GET: '/api/v1/enrollments/interested_courses'
      def interested_courses
        enrollments = current_user.enrollments.where(status: 'interested')
        render_with(enrollments)
      end

      # GET: '/api/v1/enrollments/completed_courses'
      def completed_courses
        enrollments = current_user.enrollments.where(status: 'completed')
        render_with(enrollments)
      end

      private

      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end

      def enrollment_params
        params.require(:enrollment).permit(:user_id, :course_id, :status, :progress, :purchased_at)
      end
    end
  end
end
