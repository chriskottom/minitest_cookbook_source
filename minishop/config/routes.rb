Rails.application.routes.draw do
  root to: "store#index"

  resources :products
  resources :carts, only: [ :destroy ]
  resources :line_items, only: [ :create ]
  resources :orders, only: [ :index, :show, :new, :create ]
  resources :users

  controller :sessions do
    get "login", action: "new"
    post "login", action: "create"
    delete "logout", action: "destroy"
  end
end
