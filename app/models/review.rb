class Review < ApplicationRecord
  # Associations
  belongs_to :course
  belongs_to :user

  # Validations
  validates :stars, presence: true
  validates :description, presence: true
end
