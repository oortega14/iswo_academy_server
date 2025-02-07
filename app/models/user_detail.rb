class UserDetail < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :social_networks, dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :dni, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :phone, presence: true
  validates :gender, presence: true
end
