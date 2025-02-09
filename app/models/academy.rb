class Academy < ApplicationRecord
  # Associations
  has_many :user_academies, dependent: :destroy
  has_many :users, through: :user_academies

  # Validations
  validate :user_can_only_have_one_academy, on: :create

  private

  def user_can_only_have_one_academy
    return unless user.academy.present?

    raise ApiExceptions::BaseException.new(:ACADEMY_ALREADY_CREATED, [], {})
  end
end
