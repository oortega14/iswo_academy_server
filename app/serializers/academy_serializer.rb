class AcademySerializer < BaseSerializer
  def serializable_hash
    case context[:view]
    when :summary
      summary_hash
    when :minimal
      minimal_hash
    when :admin
      admin_hash
    else
      full_hash
    end
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

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      name: resource.name,
      description: resource.description
    }
  end

  # Minimal Hash response
  def minimal_hash
    {
      id: resource.id,
      name: resource.name
    }
  end

  # Admin Hash response
  def admin_hash
    {
      id: resource.id,
      learning_routes: active_learning_routes,
      courses: active_courses,
      messages: active_messages,
      badges: active_badges,
      updated_at: resource.updated_at
    }
  end

  private

  def active_learning_routes
    LearningRoute.where(academy_id: resource.id, status: 'published').length
  end

  def active_courses
    Course.where(academy_id: resource.id, status: 'published').length
  end

  def active_messages
    0
  end

  def active_badges
    0
  end
end
