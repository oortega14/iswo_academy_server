Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             },
             defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :academies do
        member do
          post 'add_professor'
          post 'enroll_student'
        end
      end

      resources :users, only: %i[index show destroy] do
        collection do
          get 'current'
        end
      end
    end
  end
end
