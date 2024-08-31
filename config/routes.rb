Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Root route
  root to: "pages#home"

  # User resources with nested lists and messages
  resources :users, only: [:new, :create, :show, :update, :destroy] do
    resources :lists, only: [:new, :create, :index, :show] # Nested lists routes under users
    resources :messages, only: [:index, :new, :create, :show]
  end

  # Custom route for unread messages count
  get '/users/:user_id/unread_messages_count', to: 'messages#unread_messages_count', as: :unread_messages_count

  # Independent resources
  resources :groceries
  resources :meat_products, only: [:index, :show]
  resources :products  # Updated from items to products
  resources :categories do
    get :products, on: :member # Updated from items to products
  end

  # List resources with additional actions
  resources :lists do
    post :add_product, on: :member  # Updated from add_item to add_product
    post :add_category, on: :member
    patch :update_product, on: :member  # Updated from update_item to update_product
    delete :destroy_product, on: :member  # Updated from destroy_item to destroy_product

    # New routes for editing and updating individual products in a list
    resources :products_lists, only: [:edit, :update, :destroy]  # Updated from items_lists to products_lists
  end

  # Category-specific routes
  get 'meat', to: 'categories#meat'
  get 'milk_and_eggs', to: 'categories#milk_and_eggs', as: :milk_and_eggs
  get 'fruits', to: 'categories#fruits', as: :fruits
  get 'vegetables', to: 'categories#vegetables', as: :vegetables
  get 'cleaning', to: 'categories#cleaning', as: :cleaning
  get 'fish', to: 'categories#fish', as: :fish
  get 'bakery', to: 'categories#bakery', as: :bakery
  get 'car', to: 'categories#car', as: :car
  get 'drink', to: 'categories#drink', as: :drink
  get 'frozen', to: 'categories#frozen', as: :frozen
  get 'cold_cuts_and_cheeses', to: 'categories#cold_cuts_and_cheeses', as: :cold_cuts_and_cheeses
  get 'hygiene', to: 'categories#hygiene', as: :hygiene
  # Add more category-specific routes as needed

  # Cart routes
  resource :cart, only: [:show] do
    post 'add_product', to: 'carts#add_product'  # Updated from add_item to add_product
    post 'add_to_list', to: 'carts#add_to_list'
    patch 'update_item/:id', to: 'carts#update_product', as: :update_product  # Updated from update_item to update_product
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item  # Updated from remove_item to remove_product
  end

  # Checkout route
  get 'checkout', to: 'checkout#show', as: :checkout

  # Mount ActionCable server
  mount ActionCable.server => '/cable'

  # Uncomment this if you create an ErrorsController
  # match '*path', to: 'errors#not_found', via: :all
end
