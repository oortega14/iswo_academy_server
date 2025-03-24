class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true

  scope :valid, -> { where('expires_at > ?', Time.current) }

  before_validation :set_defaults, on: :create

  def expired?
    expires_at <= Time.current
  end

  def self.find_valid(token)
    valid.find_by(token: token)
  end

  private

  def set_defaults
    self.token ||= SecureRandom.hex(32)
    self.expires_at ||= 1.day.from_now
  end
end
