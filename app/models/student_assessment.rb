class StudentAssessment < ApplicationRecord
  # Associations
  belongs_to :assessment
  belongs_to :student, class_name: 'User'

  has_many :student_responses, dependent: :destroy

  # Enums
  enum status: { pending: 0, completed: 1, graded: 2 }

  # Methods
  def passed?
    score >= assessment.approve_with
  end

  def can_attempt?
    return false if attempts >= assessment.max_attempts
    return true if last_attempt_at.nil?

    Time.current >= last_attempt_at + assessment.retry_after.minutes
  end

  def register_attempt
    update!(attempts: attempts + 1, last_attempt_at: Time.current)
  end
end
