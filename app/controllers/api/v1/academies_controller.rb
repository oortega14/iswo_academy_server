module Api
  module V1
    class AcademiesController < BaseController
      before_action :set_academy, only: %i[show update destroy add_professor enroll_student]
      before_action :authorize_admin!, only: %i[update destroy add_professor]

      # GET '/api/v1/academies'
      def index
        academies = Academy.all
        render json: academies, status: :ok
      end

      # GET '/api/v1/academies/:id'
      def show
        render json: @academy, status: :ok
      end

      # POST '/api/v1/academies'
      def create
        debugger
        academy = Academy.new(academy_params.merge(admin_id: current_user.id))
        if academy.save
          UserAcademy.create!(user: current_user, academy: academy, role: 'admin')
          render json: academy, status: :created
        else
          render json: { errors: academy.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT '/api/v1/academies/:id'
      def update
        if @academy.update(academy_params)
          render json: @academy, status: :ok
        else
          render json: { errors: @academy.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE '/api/v1/academies/:id'
      def destroy
        @academy.destroy
        render json: { message: 'Academia eliminada' }, status: :ok
      end

      # POST '/api/v1/academies/:id/add_professor'
      def add_professor
        user = User.find_by(email: params[:email])
        if user && !@academy.users.include?(user)
          UserAcademy.create!(user: user, academy: @academy, role: 'professor')
          render json: { message: 'Profesor agregado con éxito' }, status: :ok
        else
          render json: { error: 'Usuario no encontrado o ya es profesor' }, status: :unprocessable_entity
        end
      end

      # POST '/api/v1/academies/:id/enroll_student'
      def enroll_student
        user = User.find_by(email: params[:email])
        if user && !@academy.users.include?(user)
          UserAcademy.create!(user: user, academy: @academy, role: 'student')
          render json: { message: 'Estudiante inscrito con éxito' }, status: :ok
        else
          render json: { error: 'Usuario no encontrado o ya está inscrito' }, status: :unprocessable_entity
        end
      end

      private

      def set_academy
        @academy = Academy.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Academia no encontrada' }, status: :not_found
      end

      def authorize_admin!
        unless current_user.is_super_admin? || current_user.user_academy&.admin?
          render json: { error: 'No autorizado' }, status: :forbidden
        end
      end

      def academy_params
        params.require(:academy).permit(:name, :description, :category_id)
      end
    end
  end
end
