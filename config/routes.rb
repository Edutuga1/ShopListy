Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Root route
  root to: "pages#home"

  # Route for user profile (accessible by logged-in user)
  resource :profile, only: %i[show edit update]

  # User resources with nested lists, conversations, friendships, and search
  resources :users, only: %i[show update destroy] do
    # Add search route for finding users by email
    collection do
      get :search  # route for user search functionality
    end

    # Nested routes for lists
    resources :lists, only: %i[new create index show]

    # Friendships routes nested under users
    resources :friendships, only: %i[index create update destroy] do
      member do
        patch 'accept', to: 'friendships#accept'  # Accept a friend request
        patch 'reject', to: 'friendships#reject'  # Reject a friend request
      end
    end

    # Conversations routes nested under users
    resources :conversations, only: %i[index new show create] do
      # Ensure this route is correctly defined for marking messages as read
      post 'mark_as_read', on: :member, to: 'conversations#mark_as_read'

      resources :messages, only: %i[create]
    end

    # Messages routes nested under users
    resources :messages, only: %i[index new create show] do
      # Custom route to delete a conversation with a specific sender
      delete 'destroy_conversation/:sender_id', to: 'messages#destroy_conversation', on: :collection, as: :destroy_conversation
    end

    # Custom route for unread messages count
    get '/unread_messages_count', to: 'messages#unread_messages_count', as: :unread_messages_count
  end

  # Independent resources
  resources :groceries
  resources :meat_products, only: %i[index show]
  resources :products
  resources :categories do
    get :products, on: :member
  end

  # List resources with additional actions
  resources :lists do
    post :add_product, on: :member
    post :add_category, on: :member
    patch :update_product, on: :member
    delete :destroy_product, on: :member
    resources :products_lists, only: [:edit, :update, :destroy]
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

  # Cart routes
  resource :cart, only: [:show] do
    post 'add_product', to: 'carts#add_product'
    post 'add_to_list', to: 'carts#add_to_list'
    patch 'update_item/:id', to: 'carts#update_product', as: :update_product
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end

  # Checkout route
  get 'checkout', to: 'checkout#show', as: :checkout

  # Mount ActionCable server
  mount ActionCable.server => '/cable'

  # Uncomment this if you create an ErrorsController
  # match '*path', to: 'errors#not_found', via: :all
end
