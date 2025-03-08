class CourseSerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      title: resource.title,
      description: resource.description,
      price: resource.price,
      status: resource.status,
      academy_id: resource.academy_id,
      creator_id: resource.creator_id,
      banner: resource.banner.url,
      promotional_image: resource.promotional_image.url,
      course_benefits: resource.course_benefits,
      course_goals: resource.course_goals,
      attachments: resource.attachments,
      learning_routes: resource.learning_routes,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
