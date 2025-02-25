class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Associations
  has_one :user_detail, dependent: :destroy
  has_many :user_academies, dependent: :destroy
  has_many :academies, through: :user_academies

  # Nested attributes
  accepts_nested_attributes_for :user_detail
  accepts_nested_attributes_for :user_academies

  # Enums
  enum :wizard_step, {
    personal_info_step: 0,
    password_step: 1,
    payment_info_step: 2,
    payment_method_step: 3,
    payment_confirmation_step: 4
  }

  # Methods
  def superadmin?
    is_super_admin
  end
end
