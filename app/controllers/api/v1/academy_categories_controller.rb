module Api
  module V1
    class AcademyCategoriesController < BaseController
      # GET '/api/v1/academy_categories'
      def index
        academy_categories = AcademyCategory.all
        render_with(academy_categories)
      end

      # GET '/api/v1/academies/:id'
      def show
        academy_category = AcademyCategory.find(params[:id])
        render_with(academy_category)
      end
    end
  end
end
