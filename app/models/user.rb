class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Associations
  has_one :user_detail, dependent: :destroy
  belongs_to :academy, optional: true

  # Nested attributes
  accepts_nested_attributes_for :user_detail

  # Methods
  def super_admin?
    is_super_admin
  end
end
