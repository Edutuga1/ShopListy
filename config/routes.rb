Rails.application.routes.draw do
  get 'static/privacy_policy'
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Root route
  root to: "pages#home"

  # Route for user profile (accessible by logged-in user)
  resource :profile, only: %i[show edit update]

  # User resources with nested lists, conversations, friendships, and search
  resources :users, only: %i[show update destroy] do
    delete 'remove_friend/:friend_id', to: 'users#remove_friend', as: 'remove_friend_user'

    # Add search route for finding users by email
    collection do
      get :search  # route for user search functionality
    end

    # Nested routes for lists
    resources :lists, only: %i[new create index show destroy edit update] do
      post :add_product, on: :member
    end

    # Friendships routes nested under users
    resources :friendships, only: %i[index create update destroy] do
      member do
        patch 'accept', to: 'friendships#accept'
        patch 'reject', to: 'friendships#reject'
      end
    end

    # Conversations routes nested under users
    resources :conversations, only: %i[index new show create destroy] do
      post 'mark_as_read', on: :member, to: 'conversations#mark_as_read'
      resources :messages, only: %i[create index]
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
  resources :products, only: [:index, :new, :create, :destroy]
  resources :categories do
    get :products, on: :member
    get 'meat', on: :collection
    get 'milk_and_eggs', on: :collection
    get 'fruits', on: :collection
    get 'vegetables', on: :collection
    get 'cleaning', on: :collection
    get 'fish', on: :collection
    get 'bakery', on: :collection
    get 'car', on: :collection
    get 'drink', on: :collection
    get 'frozen', on: :collection
    get 'cold_cuts_and_cheeses', on: :collection
    get 'hygiene', on: :collection
    get 'pasta', on: :collection
    get 'snacks', on: :collection
    get 'pharmacy', on: :collection
    get 'baby', on: :collection
    get 'pets', on: :collection
  end

  # List resources with additional actions
  resources :lists do
    # Member routes (these are actions that act on a specific list)
    post :add_product, on: :member
    post :add_category, on: :member
    post :share, on: :member  # Custom share route
    patch :update_product, on: :member
    delete :destroy_product, on: :member
    match :save_shared_list, via: [:get, :post]
    delete :remove_saved, on: :member

    # Nested routes for products_list
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
  get 'pasta', to: 'categories#pasta', as: :pasta
  get 'contact-us', to: 'pages#contact_us', as: :contact_us
  get 'snacks', to: 'categories#snacks', as: :snacks
  get 'pharmacy', to: 'categories#pharmacy', as: :pharmacy
  get 'baby', to: 'categories#baby', as: :baby
  get 'pets', to: 'categories#pets', as: :pets

  #  Footer routes

  get 'privacy-policy', to: 'static#privacy_policy', as: :privacy_policy
  get 'terms-of-service', to: 'pages#terms_of_service', as: :terms_of_service

  # Cart routes
  resource :cart, only: [:show] do
    post 'add_product', to: 'carts#add_product'
    post 'add_to_list', to: 'carts#add_to_list'
    patch 'update_item/:id', to: 'carts#update_product', as: :update_product
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
    delete 'clear', on: :member
  end

  # Settings route
  resource :settings, only: [:show, :update, :edit], controller: 'settings'

  # Checkout route
  get 'checkout', to: 'checkout#show', as: :checkout

   # Namespace for admin routes
   namespace :admin do
    resources :users, only: [:index, :show, :update, :destroy] do
      member do
        patch :toggle_admin
        delete :destroy
        patch :reset_password
      end
    end
  end

  # Mount ActionCable server
  mount ActionCable.server => '/cable'

  # Uncomment this if you create an ErrorsController
  # match '*path', to: 'errors#not_found', via: :all

end
