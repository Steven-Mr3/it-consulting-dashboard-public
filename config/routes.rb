Rails.application.routes.draw do
  devise_for :users

  # Root path
  root "dashboard#index"

  # Resources
  resources :tickets do
    resources :comments, only: [:create, :destroy]
  end

  resources :clients
  resources :kb_articles do
    member do
      post :increment_views
      post :mark_helpful
      post :mark_unhelpful
    end
  end

  resources :alerts, only: [:index] do
    member do
      patch :resolve
    end
  end

  resources :reports, only: [:index] do
    collection do
      get :export_pdf
    end
  end

  # Dashboard
  get "dashboard", to: "dashboard#index", as: :dashboard

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
