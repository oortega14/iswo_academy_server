Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
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
                   registrations: 'users/registrations'
                 },
                 defaults: {
                   format: :json
                 }

      resources :users, only: %i[index show destroy] do
        collection do
          get 'current'
        end
      end

      # Payments routes
      post "payments/webhook", to: "api/v1/payments#webhook"
    end
  end
end
