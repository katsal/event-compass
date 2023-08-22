Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:show]
  resources :lists, only: [:new, :create, :show]

  # resources :user_chats, only: [:index, :destroy]
  # resources :chatrooms, only: [:show, :create] do
  #   resources :messages, only: [:create]
  #   resources :user_chats, only: [:create]
  # end

  resources :events, only: [:new, :create, :show, :index] do
    resources :comments, only: [:create]
  end
end
