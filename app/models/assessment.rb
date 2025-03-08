class Assessment < ApplicationRecord
  # Associations
  belongs_to :course
  belongs_to :course_section, optional: true

  # Validations
  validates :course_section, presence: true, if: -> { quiz? }

  # Scopes
  scope :quizzes, -> { where(type: 'Quiz') }
  scope :final_exams, -> { where(type: 'FinalExam') }

  # Methods
  def quiz?
    type == 'Quiz'
  end

  def final_exam?
    type == 'FinalExam'
  end
end
