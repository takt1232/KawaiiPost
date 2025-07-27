Rails.application.routes.draw do
  get "comments/edit"
  get "posts/new"
  get "posts/edit"
  get "posts/delete"

  namespace :admin do
    get "comments/index"
    get "posts/index"
    get "dashboard", to: "dashboard#index"
    resources :posts, only: [ :destroy, :show ] do
      collection do
        delete :bulk_delete
      end
      resources :comments, only: [ :edit, :update ] do
      end
    end
    resources :comments, only: [ :destroy ] do
      collection do
          delete :bulk_delete
        end
    end
  end

  devise_for :admin, controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :posts do
    resources :comments, only: [ :create, :edit, :destroy, :update ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"
end
