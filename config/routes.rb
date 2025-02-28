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
      end

      # Payments routes
      post 'payments/webhook', to: 'api/v1/payments#webhook'
    end
  end
end
