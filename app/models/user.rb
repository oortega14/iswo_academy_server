class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable,
  #       :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Associations
  has_one :user_detail, dependent: :destroy
  belongs_to :academy, optional: true

  # Callbacks
  after_create :create_user_detail

  # Methods
  def super_admin?
    is_super_admin
  end

  private

  def create_user_detail
    UserDetail.create!(user: self, username: email.split('@').first)
  end
end
