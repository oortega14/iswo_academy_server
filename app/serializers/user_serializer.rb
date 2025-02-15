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
      user_detail: {
        first_name: resource.user_detail&.first_name,
        last_name: resource.user_detail&.last_name,
        birth_date: resource.user_detail&.birth_date,
        phone: resource.user_detail&.phone,
        dni: resource.user_detail&.dni,
        gender: resource.user_detail&.gender,
        username: resource.user_detail&.username,
        address: {
          address: resource.user_detail&.address&.address,
          city: resource.user_detail&.address&.city,
          province: resource.user_detail&.address&.province,
          country: resource.user_detail&.address&.country,
          postal_code: resource.user_detail&.address&.postal_code
        },
        social_networks: resource.user_detail&.social_networks
      }
    }
  end
end
