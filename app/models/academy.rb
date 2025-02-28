class Academy < ApplicationRecord
  # Associations
  has_many :user_academies, dependent: :destroy
  has_many :users, through: :user_academies
end
