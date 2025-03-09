# Define course section serializer
class CourseSectionSerializer < BaseSerializer
  def serializable_hash
    case context[:view]
    when :summary
      summary_hash
    when :minimal
      minimal_hash
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
      position: resource.position,
      course_id: resource.course_id,
      lessons: resource.lessons,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end

  # Summary Hash response
  def summary_hash
    {
      id: resource.id,
      name: resource.name,
      position: resource.position
    }
  end
end
