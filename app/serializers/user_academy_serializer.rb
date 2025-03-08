class UserAcademySerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      academy_id: resource.academy_id,
      academy_name: resource.academy.name,
      academy_logo: resource.academy.logo.url,
      academy_banner: resource.academy.banner.url,
      role: resource.role,
      academy_description: resource.academy.description,
      academy_domain: resource.academy.academy_configuration.domain
    }
  end
end
