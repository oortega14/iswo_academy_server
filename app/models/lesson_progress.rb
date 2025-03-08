class LessonProgress < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :lesson

  # Enums
  enum status: {
    pending: 'pending',
    in_progress: 'in_progress',
    completed: 'completed'
  }
end
