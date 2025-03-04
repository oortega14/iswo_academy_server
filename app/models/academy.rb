class Academy < ApplicationRecord
  # Associations
  has_many :user_academies, dependent: :destroy
  has_many :users, through: :user_academies
  has_many :academy_configurations, dependent: :destroy

  # Nested Attributes
  accepts_nested_attributes_for :academy_configurations, allow_destroy: true
end
