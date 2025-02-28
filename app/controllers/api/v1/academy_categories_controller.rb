module Api
  module V1
    class AcademyCategoriesController < BaseController
      # GET '/api/v1/academy_categories'
      def index
        academy_categories = AcademyCategory.all
        render json: academy_categories, status: :ok
      end

      # GET '/api/v1/academies/:id'
      def show
        academy_category = AcademyCategory.find(params[:id])
        render json: academy_category, status: :ok
      end
    end
  end
end
