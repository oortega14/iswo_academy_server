class UserDetail < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :social_networks, dependent: :destroy

  # Enums
  enum gender: { :male => 0, :female => 1 }

  # Validations
  validates :username, :dni, presence: true, uniqueness: true
  validates :first_name, :last_name, :birth_date, :phone, :gender, presence: true
end
