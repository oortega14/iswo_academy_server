class CertificateConfiguration < ApplicationRecord
  # Associated blobs
  has_one_attached :certificate_template

  # Associations
  belongs_to :course

  # Validations
  validates :course, presence: true
  validate :certificate_template_presence
  validate :course_only_has_one_certificate_configuration

  private

  def certificate_template_presence
    return if certificate_template.attached?

    raise ApiExceptions::BaseException.new(:CERTIFICATE_TEMPLATE_REQUIRED, [], {})
  end

  def course_only_has_one_certificate_configuration
    if CertificateConfiguration.where(course: course).where.not(id: id).exists?
      raise ApiExceptions::BaseException.new(:COURSE_ONLY_HAS_ONE_CERTIFICATE_CONFIGURATION, [], {})
    end
  end
end
