class UserDetail < ApplicationRecord
  # Associations
  belongs_to :user

  has_many :social_networks, dependent: :destroy
  has_one :address, dependent: :destroy

  # Enums
  enum :gender, { male: 0, female: 1, other: 2 }

  # Nested attributes
  accepts_nested_attributes_for :social_networks, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  # Validations
  validates :username, :dni, presence: true, uniqueness: true, on: :update
  validates :first_name, :last_name, :birth_date, :phone, :gender, presence: true, on: :update

  def full_name
    "#{first_name} #{last_name}"
  end
end
