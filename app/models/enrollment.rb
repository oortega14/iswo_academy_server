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
end
