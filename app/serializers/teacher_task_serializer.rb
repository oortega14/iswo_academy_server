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
      status: I18n.t("teacher_tasks.status.#{resource.status}"),
      course_name: resource.course.title,
      teacher_name: resource.teacher.user_detail.full_name,
      material_attachments: material_attachments,
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
      status: I18n.t("teacher_tasks.status.#{resource.status}"),
      course_name: resource.course.title,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  def material_attachments
    resource.attachments.where(category: 'task_material').map do |attachment|
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
