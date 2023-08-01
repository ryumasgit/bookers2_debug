Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    get "search" => "users#search"
    resource :relationships, only: [:create, :destroy]
  get 'follows' => 'relationships#follows', as: 'follows'
  get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :messages, only: [:create, :show]
  resources :groups, only: [:new, :show, :index, :edit, :create, :update] do
    get "join" => "groups#join"
    delete '/groups/:group_id/leave', to: 'groups#leave', as: 'leave'
  end
  resources :view_counts, only: [:create]

  get "/home/about", to: "homes#about", as: "about"
  get 'search' => 'searches#search'
end
