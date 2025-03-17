class CourseSerializer < BaseSerializer
  def serializable_hash
    case context[:view]
    when :summary
      summary_hash
    else
      full_hash
    end
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
      attachments: attachments,
      learning_routes: resource.learning_routes,
      final_exam: resource.final_exam,
      duration: resource&.certificate_configuration&.course_time&.to_i,
      students_count: resource.enrollments.where(status: 'purchased').size,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      title: resource.title,
      final_exam: resource.final_exam
    }
  end

  def attachments
    resource.attachments.map do |attachment|
      {
        id: attachment.id,
        attachable_type: attachment.attachable_type,
        attachable_id: attachment.attachable_id,
        type: attachment.type,
        url: attachment.url || attachment.file.url,
        category: attachment.category,
        created_at: attachment.created_at,
        updated_at: attachment.updated_at
      }
    end
  end
end
