class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Associations
  has_one :user_detail, dependent: :destroy
  has_many :user_academies, dependent: :destroy
  has_many :academies, through: :user_academies

  # Nested attributes
  accepts_nested_attributes_for :user_detail
  accepts_nested_attributes_for :user_academies

  # Methods
  def super_admin?
    is_super_admin
  end
end
