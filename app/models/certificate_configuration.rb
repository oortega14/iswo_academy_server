class CertificateConfiguration < ApplicationRecord
  # Associations
  belongs_to :course

  # Validations
  validates :course, presence: true
end
