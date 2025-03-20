class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy update]
  # skip_before_action :set_current_academy, only: %i[me]

  # GET '/api/v1/users'
  def index
    unless current_user.is_super_admin
      return render json: { error: 'No autorizado' }, status: :forbidden
    end
    render json: User.all, status: :ok
  end

  # GET '/api/v1/users/:id'
  def update
    @user.update!(user_params)
    render_with(@user)
  end

  # GET '/api/v1/users/:id'
  def show
    render_with(@user)
  end

  # DELETE '/api/v1/users/:id'
  def destroy
    unless current_user.is_super_admin?
      return render json: { error: 'No autorizado' }, status: :forbidden
    end
    @user.destroy
    render json: { message: 'Usuario eliminado' }, status: :ok
  end

  # GET '/api/v1/users/me'
  def me
    render json: serialize_item(current_user, UserSerializer), status: :ok
  end

  # POST '/api/v1/users/set_active_academy'
  def set_active_academy
    current_user.update!(active_academy_id: params[:academy_id])
    user_academy = UserAcademy.find_by(user: current_user, academy_id: params[:academy_id])
    render json: serialize_item(user_academy, UserAcademySerializer), status: :ok
  end

  def refresh
    refresh_token = params[:refresh_token]
    token_record = RefreshToken.find_valid(refresh_token)

    if token_record
      user = token_record.user
      access_token = JwtService.encode({ sub: user.id })

      render json: {
        access_token: access_token,
        user: serialize_item(user, UserSerializer)
      }, status: :ok
    else
      render json: { error: 'Invalid refresh token' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :is_super_admin, :is_active, :is_profile_completed, :wizard_step, :profile_picture,
      user_detail_attributes: [
        :id, :first_name, :last_name, :phone, :birth_date, :dni, :gender, :username,
        address_attributes: %i[id address city province country postal_code user_detail_id _destroy],
        social_networks_attributes: %i[id platform url user_detail_id _destroy]
      ],
      user_academies_attributes: [
        :id, :academy_id, :role, :user_id
      ]
    )
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Usuario no encontrado' }, status: :not_found
  end
end
