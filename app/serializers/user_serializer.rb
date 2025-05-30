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
      is_super_admin: resource.is_super_admin,
      profile_picture: resource.profile_picture.url,
      is_active: resource.is_active,
      is_profile_completed: resource.is_profile_completed,
      active_academy_id: resource.active_academy_id,
      wizard_step: resource.wizard_step,
      color_palette: resource.active_academy&.academy_configuration&.color_palette,
      user_detail: {
        id: resource.user_detail&.id,
        first_name: resource.user_detail&.first_name,
        last_name: resource.user_detail&.last_name,
        birth_date: resource.user_detail&.birth_date,
        phone: resource.user_detail&.phone,
        dni: resource.user_detail&.dni,
        gender: resource.user_detail&.gender,
        username: resource.user_detail&.username,
        address: {
          id: resource.user_detail&.address&.id,
          address: resource.user_detail&.address&.address,
          city: resource.user_detail&.address&.city,
          province: resource.user_detail&.address&.province,
          country: resource.user_detail&.address&.country,
          postal_code: resource.user_detail&.address&.postal_code
        },
        social_networks: resource.user_detail&.social_networks
      },
      user_academies: resource.user_academies.order(created_at: :desc).map do |user_academy|
        {
          id: user_academy.id,
          user_id: user_academy.user_id,
          academy_id: user_academy.academy_id,
          role: user_academy.role
        }
      end
    }
  end
end
