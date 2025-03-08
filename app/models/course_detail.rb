class CourseDetail < ApplicationRecord
  # Associations
  belongs_to :course

  # Validations
  validates :description, presence: true
  validates :type, presence: true
end
