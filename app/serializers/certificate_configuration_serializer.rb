class CertificateConfigurationSerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      course_id: resource.course_id,
      course_name: resource.course_name,
      course_time: resource.course_time,
      certificate_template: resource.certificate_template.url,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
