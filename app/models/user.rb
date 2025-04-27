class User < ApplicationRecord
  # Attached Files
  has_one_attached :profile_picture

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Associations
  has_one :user_detail, dependent: :destroy

  has_many :lesson_progresses
  has_many :lessons, through: :lesson_progresses

  has_many :user_academies, dependent: :destroy
  has_many :academies, through: :user_academies
  has_many :certificates, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  belongs_to :active_academy, class_name: 'Academy', optional: true

  # Nested attributes
  accepts_nested_attributes_for :user_detail
  accepts_nested_attributes_for :user_academies

  # Enums
  enum :wizard_step, {
    # Comunes a todos
    personal_info_step: 0,
    password_step: 1,

    # Student
    student_academy_selection_step: 2,
    student_confirmation_step: 3,

    # Teacher
    teacher_academy_request_step: 4,
    teacher_confirmation_step: 5,

    # Admin
    admin_payment_info_step: 6,
    admin_payment_success_step: 7,
    admin_create_academy_step: 8,
    admin_preferences_step: 9,
    admin_confirmation_step: 10
  }

  # Validations
  validates :email, presence: true, uniqueness: true

  # Methods
  def superadmin?
    is_super_admin
  end
end
