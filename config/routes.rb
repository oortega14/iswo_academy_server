Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Academy Categories routes
      resources :academy_categories, only: %i[index show]

      # Academy routes
      resources :academies do
        member do
          post 'add_professor'
          post 'enroll_student'
        end
      end

      # User routes
      devise_for :users,
                 controllers: {
                   sessions: 'users/sessions',
                   registrations: 'users/registrations',
                   confirmations: 'api/v1/confirmations'
                 },
                 defaults: {
                   format: :json
                 }

      resources :users, only: %i[index show destroy update] do
        get :me, on: :collection
        post :set_active_academy, on: :collection
      end

      resources :user_academies, only: %i[index] do
        get :get_role, on: :collection
      end

      # Learning Routes routes
      resources :learning_routes

      # Courses routes
      resources :courses do
        # Course Sections routes
        resources :course_sections do
          member do
            post 'move_up'
            post 'move_down'
          end
        end
      end

      # Payments routes
      post 'payments/webhook', to: 'api/v1/payments#webhook'
    end
  end
end
