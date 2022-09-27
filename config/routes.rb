Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "homes/about" => "homes#about", as: "about"
  resources :books, only: [:new, :edit, :create, :index, :show, :destroy, :update]
  
  resources :users, only: [:show, :edit, :index, :update]
end
