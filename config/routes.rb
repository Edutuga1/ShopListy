# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: [:new, :create, :show, :update, :destroy] do
    resources :groceries, only: [:index, :create, :update, :destroy]
    resources :lists, only: [:index, :new, :create, :show, :edit, :update] 
    resources :items, only: [:index]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
