class UserSerializer < BaseSerializer
  def serializable_hash
    full_hash
  end

  private

  # Full Hash response
  def full_hash
    {
      id: resource.id,
      email: resource.email,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
