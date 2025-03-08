class AcademySerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      name: resource.name,
      description: resource.description,
      admin_id: resource.admin_id,
      category_id: resource.category_id,
      academy_configuration: resource.academy_configuration,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
