class EnrollmentSerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      user_id: resource.user_id,
      course_id: resource.course_id,
      status: resource.status,
      progress: resource.progress,
      purchased_at: resource.purchased_at,
      user_name: resource.user.user_detail.full_name,
      user_email: resource.user.email,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
