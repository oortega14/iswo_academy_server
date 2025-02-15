class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, except: %i[index show]
  before_action :set_user, only: %i[show destroy]
  # skip_before_action :set_current_academy, only: %i[me]

  # GET '/api/v1/users'
  def index
    unless current_user.is_super_admin?
      return render json: { error: 'No autorizado' }, status: :forbidden
    end
    render json: User.all, status: :ok
  end

  # GET '/api/v1/users/current'
  def update
    if current_user.update(user_params)
      render json: current_user, status: :ok
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
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

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Usuario no encontrado' }, status: :not_found
  end
end
