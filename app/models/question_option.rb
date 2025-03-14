class QuestionOption < ApplicationRecord
  # Associations
  belongs_to :question

  # Validations
  validates :content, presence: true
  validates :correct, inclusion: { in: [true, false] }
end
