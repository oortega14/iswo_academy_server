class QuizSerializer < BaseSerializer
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
      teacher_id: resource.teacher_id,
      course_id: resource.course_id,
      course_section_id: resource.course_section_id,
      type: resource.type,
      name: resource.name,
      time_limit: resource.time_limit,
      retry_after: resource.retry_after,
      approve_with: resource.approve_with,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      teacher_id: resource.teacher_id,
      course_id: resource.course_id,
      course_section_id: resource.course_section_id,
      type: resource.type,
      name: resource.name
    }
  end
end
