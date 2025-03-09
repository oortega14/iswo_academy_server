class Academy < ApplicationRecord
  # Associated blobs
  has_one_attached :banner
  has_one_attached :logo

  # Associations
  has_many :user_academies, dependent: :destroy
  has_many :users, through: :user_academies
  has_one :academy_configuration, dependent: :destroy
  has_many :learning_routes, dependent: :destroy
  has_many :courses, dependent: :destroy

  # Nested Attributes
  accepts_nested_attributes_for :academy_configuration, allow_destroy: true
end
