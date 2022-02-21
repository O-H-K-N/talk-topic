Rails.application.routes.draw do
  get 'user_sessions/new'
  get 'user_sessions/create'
  get 'user_sessions/destroy'
  root "homes#index"

  resources :users

  get '/login', to: 'user_sessions#new', as: :login
  post '/login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  get '/sign_up', to: 'users#new', as: :sign_up
  post '/sign_up', to: 'users#create'
end
