class AcademyCategory < ApplicationRecord
  # Associations
  has_many :academies, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
end
