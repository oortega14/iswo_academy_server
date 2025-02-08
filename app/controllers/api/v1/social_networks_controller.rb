class Api::V1::SocialNetworksController < ApplicationController
  before_action :authenticate_user!

  # POST '/api/v1/social_networks'
  def create
    social_network = SocialNetwork.new(social_network_params)

    if social_network.save
      render json: { message: 'Red social agregada correctamente', social_network: social_network }, status: :created
    else
      render json: { errors: social_network.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT '/api/v1/social_networks/:id'
  def update
    social_network = SocialNetwork.find(params[:id])

    if social_network.update(social_network_params)
      render json: { message: 'Red social actualizada correctamente', social_network: social_network }, status: :ok
    else
      render json: { errors: social_network.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE '/api/v1/social_networks/:id'
  def destroy
    social_network = SocialNetwork.find(params[:id])

    if social_network.destroy
      render json: { message: 'Red social eliminada correctamente' }, status: :ok
    else
      render json: { errors: social_network.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def social_network_params
    params.require(:social_network).permit(:user_detail_id, :platform, :url)
  end
end
