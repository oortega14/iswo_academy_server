class CoursePurchase < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course

  # Enums
  enum status: { pending: 0, paid: 1, failed: 2 }
end
