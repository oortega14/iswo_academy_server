class Subscription < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :academy, optional: true

  # Enums
  enum status: { pending: 0, paid: 1, failed: 2 }

  # Validations
  validates :amount, presence: true
  validates :status, presence: true

  # Scopes
  scope :currently_active, -> { where(status: :active).where('expires_at > ?', Time.current) }
end
