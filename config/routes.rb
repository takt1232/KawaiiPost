Rails.application.routes.draw do
  get "comments/edit"
  get "posts/new"
  get "posts/edit"
  get "posts/delete"
  get "admin/dashboard"
  get "admin/posts"
  get "admin/comments"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  devise_for :admin, controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  resources :posts do
    resources :comments, only: [ :create, :edit, :destroy ]
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
