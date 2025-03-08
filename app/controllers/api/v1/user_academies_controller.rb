module Api
  module V1
    class UserAcademiesController < BaseController
      # GET '/api/v1/user_academies'
      def index
        user_academies = UserAcademy.where(user: current_user)
        render_with(user_academies)
      end

      # GET '/api/v1/user_academies/role'
      def get_role
        user_academy = UserAcademy.find_by(
          user_id: params[:user_id],
          academy_id: params[:academy_id]
        )

        if user_academy
          render json: { value: user_academy.role }
        else
          render json: { error: 'User academy role not found' }, status: :not_found
        end
      end
    end
  end
end
