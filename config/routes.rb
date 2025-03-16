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
        # Courses routes
        resources :courses do
          post 'publish', on: :member
          post 'unpublish', on: :member
          # Certificate Configurations routes
          resources :certificate_configurations

          # Teacher Tasks routes
          resources :teacher_tasks

          # Course Sections routes
          resources :course_sections do
            member do
              patch 'move_up'
              patch 'move_down'
            end
            # Lesson routes
            resources :lessons do
              member do
                patch 'update_visibility'
                patch 'move_up'
                patch 'move_down'
              end
            end
          end
        end

        # Learning Routes routes
        resources :learning_routes
      end

      # Assessments routes
      resources :quizzes
      resources :final_exams
      resources :questions

      resources :student_quizzes, only: [:index, :show] do
        member do
          post :start
          post :submit
        end
      end

      resources :student_final_exams, only: [:index, :show] do
        member do
          post :start
          post :submit
        end
      end

      # Enrollments routes
      resources :enrollments do
        collection do
          post 'create_simple'
          post 'create_multiple'
        end
      end

      # Templates routes
      get '/templates/students_template', to: 'templates#students_template'

      # User routes
      devise_for :users,
                 controllers: {
                   sessions: 'users/sessions',
                   registrations: 'users/registrations',
                   confirmations: 'api/v1/confirmations',
                   passwords: 'users/passwords'
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

      # Payments routes
      post 'payments/webhook', to: 'api/v1/payments#webhook'
    end
  end
end
