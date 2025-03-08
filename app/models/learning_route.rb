# learning_route Model
class LearningRoute < ApplicationRecord
  # Associations
  belongs_to :academy

  has_and_belongs_to_many :courses

  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true

  # Enums
  enum status: {
    draft: 0,
    published: 1
  }, _prefix: :route
end
