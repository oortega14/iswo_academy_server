class Assessment < ApplicationRecord
  # Associations
  belongs_to :course
  belongs_to :course_section, optional: true
  belongs_to :teacher, class_name: 'User'

  has_many :questions, dependent: :destroy
  has_many :student_assessments, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :time_limit, numericality: { greater_than: 0 }, allow_nil: true
  validates :approve_with, numericality: { greater_than_or_equal_to: 0 }
  validates :retry_after, numericality: { greater_than_or_equal_to: 1 }

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
