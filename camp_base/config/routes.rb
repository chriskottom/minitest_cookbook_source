Rails.application.routes.draw do
  root to: "home#index"
  resources :projects
  resources :users
  post "/login", to: "sessions#create", as: "login"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
