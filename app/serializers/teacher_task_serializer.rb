class TeacherTaskSerializer < BaseSerializer
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
      due_date: resource.due_date,
      status: resource.status,
      course_name: resource.course.title,
      teacher_name: resource.teacher.user_detail.full_name,
      course_id: resource.course_id,
      course_section_id: resource&.course_section_id,
      teacher_id: resource.teacher_id,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      title: resource.title,
      description: resource.description,
      due_date: resource.due_date,
      status: resource.status,
      course_name: resource.course.title,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
