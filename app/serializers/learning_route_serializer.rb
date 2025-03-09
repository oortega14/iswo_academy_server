class LearningRouteSerializer < BaseSerializer
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
      status: resource.status,
      academy_id: resource.academy_id,
      courses: resource.courses,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
