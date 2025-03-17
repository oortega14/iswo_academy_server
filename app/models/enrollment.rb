class Enrollment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course

  # Validations
  validates :user_id, uniqueness: { scope: :course_id, message: 'ya está inscrito en este curso' }

  # Enums
  enum :status, {
    interested: 0,
    purchased: 1,
    finished: 2
  }

  enum :progress, {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  # Callbacks
  after_create :set_tasks

  private

  def set_tasks
    course.teacher_tasks.each do |task|
      debugger
      StudentTask.create!(
        course: course,
        student: user,
        teacher_task_id: task.id,
        status: :pending,
        due_date: task.due_date
      )
    end
  end
end
