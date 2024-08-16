Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Root route
  root to: "pages#home"

  # User resources with nested lists
  resources :users, only: [:new, :create, :show, :update, :destroy] do
    resources :lists, only: [:new, :create, :index, :show] # Nested lists routes under users
  end

  # Independent resources
  resources :groceries
  resources :meat_products, only: [:index, :show]
  resources :items
  resources :categories do
    get :items, on: :member # Nested items route under categories
  end

  # List resources with additional actions
  resources :lists do
    post :add_item, on: :member
    post :add_category, on: :member
  end

  # Category-specific routes
  get 'meat', to: 'categories#meat'
  get 'milk_and_eggs', to: 'categories#milk_and_eggs'
  # Add more category-specific routes as needed

  # Cart routes
  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    post 'add_to_list', to: 'carts#add_to_list'
    patch 'update_item/:id', to: 'carts#update_item', as: :update_item
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end

  # Checkout route
  get 'checkout', to: 'checkout#show', as: :checkout

  # Uncomment this if you create an ErrorsController
  # match '*path', to: 'errors#not_found', via: :all
end
