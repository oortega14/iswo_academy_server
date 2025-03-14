class CorrectAnswer < ApplicationRecord
  # Associations
  belongs_to :question

  # Validations
  validates :content, presence: true
end
