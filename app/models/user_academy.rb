class UserAcademy < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :academy, optional: true

  # Validations
  validates :role, presence: true
  validate :user_can_only_have_one_academy, on: :create

  # Enums
  enum :role, { student: 0, professor: 1, admin: 2 }

  private

  def user_can_only_have_one_academy
    return unless role == 'admin'

    if user.user_academies.admin.where.not(id: id).exists?
      raise ApiExceptions::BaseException.new(:ALREADY_ADMIN_IN_OTHER_ACADEMY, [], {})
    end
  end
end
