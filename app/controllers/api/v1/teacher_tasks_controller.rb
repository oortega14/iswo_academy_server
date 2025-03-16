module Api
  module V1
    class TeacherTasksController < ApplicationController
      before_action :set_teacher_task, only: %i[show update destroy]

      def index
        teacher_tasks = policy_scope(TeacherTask)
        render_with(teacher_tasks)
      end

      def show
        render_with(@teacher_task)
      end

      def create
        teacher_task = TeacherTask.new(teacher_task_params)
        teacher_task.teacher_id = current_user.id
        teacher_task.course_id = params[:course_id]
        authorize teacher_task

        render_with(teacher_task)
      end

      def update
        authorize @teacher_task

        @teacher_task.update!(teacher_task_params)
        render_with(@teacher_task)
      end

      def destroy
        authorize @teacher_task

        render_with(@teacher_task)
      end

      private

      def set_teacher_task
        @teacher_task = TeacherTask.find(params[:id])
      end

      def teacher_task_params
        params.require(:teacher_task).permit(
          :title,
          :description,
          :due_date,
          :status,
          :deleted_at,
          :course_id,
          :course_section_id,
          :teacher_id,
          attachments_attributes: %i[id file attachable_id attachable_type category type url _destroy]
        )
      end
    end
  end
end
