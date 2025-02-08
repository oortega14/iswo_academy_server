module Users
  # Define Registrations Controller
  class RegistrationsController < Devise::RegistrationsController
    # Responders
    respond_to :json

    def sign_up_params
      params.require(:user).permit(:email,
                                   :is_super_admin,
                                   :password,
                                   :password_confirmation,
                                   user_detail_attributes: [:first_name, :last_name, :gender, :birth_date, :dni, :username, :phone, :address, :city, :province, :country, :postal_code,
                                   social_networks_attributes: [:platform, :url]],
                                   academy_user_attributes: [:academy_id])
    end

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed
    end

    def register_success
      render json: {
        message: 'Signed up succesfully.',
        user: resource
      }, status: :ok
    end

    def register_failed
      errors = []
      resource.errors.each do |error|
        errors << "#{error.attribute} #{error.message}"
      end
      raise ApiExceptions::BaseException.new(:FAILED_REGISTRATION, [errors], {})
    end
  end
end
