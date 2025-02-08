module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      def not_found
        render json: { error: 'recurso no encontrado' }, status: :not_found
      end
    end
  end
end
