class Notification < ApplicationRecord
  # Associations
  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  # Enums
  enum :status, { unread: 0, read: 1 }

  # Validations
  validates :message, presence: true
end
