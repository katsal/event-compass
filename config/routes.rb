Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:show, :update] do
    resources :messages, only: [:create, :index]
    member do
      post 'follow' => 'users#follow'
      delete 'unfollow' => 'users#unfollow'
      patch 'update_social'
    end
  end

  resources :comments, only: [:create, :destroy] do
    member do
      post 'vote' => 'comments#vote'
    end
  end

  resources :lists, only: [:new, :create, :show, :destroy]

  # resources :user_chats, only: [:index, :destroy]
  # resources :chatrooms, only: [:show, :create] do
  #   resources :messages, only: [:create]
  #   resources :user_chats, only: [:create]
  # end

  resources :events, only: [:new, :create, :show, :index] do
    resources :event_lists, only: [:create, :destroy]
  end
end
