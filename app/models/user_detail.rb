class UserDetail < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :social_networks, dependent: :destroy

  # Enums
  enum gender: { male: 0, female: 1 }

  # Nested attributes
  accepts_nested_attributes_for :social_networks, allow_destroy: true

  # Validations
  validates :username, :dni, presence: true, uniqueness: true
  validates :first_name, :last_name, :birth_date, :phone, :gender, presence: true
end
