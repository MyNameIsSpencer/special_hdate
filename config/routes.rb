Rails.application.routes.draw do
  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout

  resources :users, except: [:index] do
    resources :results, only: [:index, :show, :create]
  end
  get 'users/:id/matches' => 'users#load_matches', :as => :user_matches
  get 'users/:id/meetups' => 'users#meetups', :as => :user_meetups
  resources :surveys, only: [:index, :show]
  resource :session, only: [:new, :create, :destroy]

  patch 'users/:id/change_status' => 'users#change_status', :as => :change_status
  root "sessions#new"

  resources :surveys, only: [:show] do
    get '/load_pictures' => 'questions#load_pictures', :as =>   :load_pictures
  end
  get 'find_event' => 'messages#find_event', :as => :find_event
  get 'chat_room' => 'chats#chat_room'
  resources :messages, only: [:create]

  patch 'user/:id/block_user' => 'users#block_user', :as => :block_user
  get 'find_user' => 'users#find_user', :as => :find_user
  get '/about_us' => 'surveys#about_us'
  patch 'read_message' => 'messages#read', :as => :read_message
end
