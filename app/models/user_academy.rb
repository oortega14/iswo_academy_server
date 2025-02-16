class UserAcademy < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :academy, optional: true

  # Validations
  validates :role, presence: true

  # Enums
  enum :role, { student: 0, professor: 1, admin: 2 }
end
