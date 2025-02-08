class AcademyConfiguration < ApplicationRecord
  belongs_to :academy

  validates :domain, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/, message: 'solo puede contener letras minúsculas, números y guiones' }
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :colors, presence: true

  before_validation :generate_default_colors, on: :create

  private

  def generate_default_colors
    self.colors ||= {
      primary: '#1E3A8A',
      secondary: '#9333EA',
      background: '#F3F4F6',
      text: '#111827',
      button: '#2563EB',
      buttonText: '#FFFFFF'
    }
  end
end
