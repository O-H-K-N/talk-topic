Rails.application.routes.draw do
  root "homes#index"

  resources :topics
  resources :tags
  resources :likes, only: :create

  get '/login', to: 'user_sessions#new', as: :login
  post '/login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
