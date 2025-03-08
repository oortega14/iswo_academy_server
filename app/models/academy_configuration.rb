class AcademyConfiguration < ApplicationRecord
  # Associations
  belongs_to :academy

  # Validations
  validates :domain,
            presence: true,
            format: { with: /\A[a-z0-9\-]+\z/, message: 'solo puede contener letras minúsculas, números y guiones' },
            uniqueness: { conditions: -> { where.not(id: nil) } }
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :color_palette, presence: true, inclusion: { in: %w[grey_breeze lavender_dreams dusty_rose calm_ocean golden_sand standard], message: 'paleta no válida' }
end
