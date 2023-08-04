Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get '/home/about', to: 'homes#about', as: 'about'
  get 'search' => 'searches#search'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    get 'search' => 'users#search'
    resource :relationships, only: [:create, :destroy]
  get 'follows' => 'relationships#follows', as: 'follows'
  get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :groups, only: [:new, :show, :index, :edit, :create, :update] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get'"event_notices' => 'event_notices#sent'
  end

  resources :messages, only: [:create, :show]
  resources :view_counts, only: [:create]
end
