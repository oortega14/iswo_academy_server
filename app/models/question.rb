class Question < ApplicationRecord
  # Associations
  belongs_to :assessment
  has_many :question_options, dependent: :destroy
  has_many :student_responses, dependent: :destroy
  has_one :correct_answer, dependent: :destroy

  # Enums
  enum :question_type, { multiple_choice: 0, short_answer: 1, true_false: 2 }

  # Validations
  validates :content, presence: true
  validates :question_type, presence: true

  # Nested attributes
  accepts_nested_attributes_for :question_options, allow_destroy: true
  accepts_nested_attributes_for :correct_answer, allow_destroy: true
end
