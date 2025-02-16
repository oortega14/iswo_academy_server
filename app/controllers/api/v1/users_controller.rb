class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, except: %i[index show]
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
    @user.update(user_params)
    render_with(@user)
  end

  # GET '/api/v1/users/:id'
  def show
    render json: @user, status: :ok
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

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :is_super_admin, :is_active, :is_profile_completed, :wizard_step,
      user_detail_attributes: [
        :first_name, :last_name, :phone, :birth_date, :dni, :gender, :username,
        address_attributes: %i[address city province country postal_code],
        social_networks_attributes: %i[platform url]
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
