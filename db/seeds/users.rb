p 'Users inicio'

user = User.new(
  email: 'cso@iswo.com.co',
  password: Rails.application.credentials.super_admin_password,
  password_confirmation: Rails.application.credentials.super_admin_password,
  is_super_admin: true,
  is_active: true,
  is_profile_completed: true,
  user_detail_attributes: {
    first_name: 'Frank',
    last_name: 'Fajardo',
    phone: '+57 312 888 2828',
    birth_date: '1990-01-01',
    dni: '1000000000',
    gender: 'male',
    username: 'frankfajardo',
    address_attributes: {
      address: 'Calle 18 # 27 - 84 Oficina 301',
      city: 'Pasto',
        province: 'Nariño',
        country: 'Colombia',
        postal_code: '520001'
    },
    social_networks_attributes: [
      {
        platform: 'facebook',
        url: 'https://www.facebook.com/frank.fajardo1'
      },
      {
        platform: 'instagram',
        url: 'https://www.instagram.com/frankfajardoromo'
      },
      {
        platform: 'linkedin',
        url: 'https://www.linkedin.com/in/frankfajardoromo'
      },
      {
        platform: 'youtube',
        url: 'https://www.youtube.com/@sigiswo'
      }
    ]
  },
)
user.skip_confirmation!
user.save!

p 'Users finalizado'
