class LessonSerializer < BaseSerializer
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
      position: resource.position,
      visible: resource.visible,
      course_section_id: resource&.course_section_id,
      video_class: video_class_attachment,
      material_attachments: material_attachments,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  def video_class_attachment
    resource.attachments.find_by(category: 'video_class').url || resource.attachments.find_by(category: 'video_class').file.url
  end

  def material_attachments
    resource.attachments.where(category: 'study_material').map do |attachment|
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
