class UserAcademy < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :academy, optional: true

  # Validations
  validates :role, presence: true
  validate :user_can_only_have_one_academy, on: :create
  validate :user_cannot_be_admin_and_student_in_same_academy, on: :create

  # Enums
  enum :role, { student: 0, professor: 1, admin: 2 }

  private

  def user_can_only_have_one_academy
    return unless role == 'admin'

    if user.user_academies.admin.where.not(id: id).exists?
      raise ApiExceptions::BaseException.new(:ALREADY_ADMIN_IN_OTHER_ACADEMY, [], {})
    end
  end

  def user_cannot_be_admin_and_student_in_same_academy
    return unless academy_id.present? && user_id.present?

    existing_user_academy = UserAcademy.find_by(
      user_id: user_id,
      academy_id: academy_id
    )

    if existing_user_academy &&
       ((existing_user_academy.role == 'admin' && role == 'student') ||
        (existing_user_academy.role == 'student' && role == 'admin'))
      raise ApiExceptions::BaseException.new(:USER_CANNOT_BE_ADMIN_AND_STUDENT_IN_SAME_ACADEMY, [], {})
    end
  end
end
