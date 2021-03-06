Rails.application.routes.draw do
  root to: 'landing#index'
  resources :sessions, only: :index
  get "/auth/:provider/callback" => 'sessions#create', as: :session_create
  get "/logout" => 'sessions#logout', as: :session_logout
end
