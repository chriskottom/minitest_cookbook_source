Rails.application.routes.draw do
  root to: "store#index"

  resources :products
  resources :line_items, only: [ :create ]
  resources :orders, only: [ :index, :show, :new, :create ]
  resources :order_extracts, only: [ :create ]
  resources :users

  controller :carts do
    delete "cart", action: "destroy"
  end

  controller :sessions do
    get "login", action: "new"
    post "login", action: "create"
    delete "logout", action: "destroy"
  end
end
