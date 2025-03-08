module Api
  module V1
    class LearningRoutesController < BaseController
      before_action :set_learning_route, only: [:show, :update, :destroy]

      # GET /learning_routes
      def index
        @learning_routes = policy_scope(LearningRoute)
        render_with(@learning_routes)
      end

      # POST /learning_routes
      def create
        learning_route = LearningRoute.new(learning_route_params)
        authorize(learning_route)
        learning_route.save!
        render_with(learning_route)
      end

      # GET /learning_routes/:id
      def show
        @learning_route = LearningRoute.find(params[:id])
        authorize(@learning_route)

        render_with(@learning_route)
      end

      # PATCH /learning_routes/:id
      def update
        authorize(@learning_route)

        @learning_route.update!(learning_route_params)
        render_with(@learning_route)
      end

      # DELETE /learning_routes/:id
      def destroy
        authorize @learning_route

        render_with(@learning_route)
      end

      private

      def set_learning_route
        @learning_route = LearningRoute.find(params[:id])
      end

      def learning_route_params
        params.require(:learning_route).permit(:name, :description, :status, :academy_id)
      end
    end
  end
end
