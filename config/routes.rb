Rails.application.routes.draw do
  get 'checkout/show'
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Root route
  root to: "pages#home"

  # User resources
  resources :users, only: [:new, :create, :show, :update, :destroy] do
    resources :lists
  end

  # Independent resources
  resources :groceries
  resources :meat_products, only: [:index, :show]
  resources :items
  resources :categories do
    get :items, on: :member
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
  end

  # Add the checkout route
  get 'checkout', to: 'checkout#show', as: :checkout

  # Catch-all route for non-matching routes (if needed)
  match '*path', to: 'errors#not_found', via: :all
end
