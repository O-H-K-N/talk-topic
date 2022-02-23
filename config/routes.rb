Rails.application.routes.draw do
  root "homes#index"

  resources :users
  resources :topics do
    collection do
      get 'tags'
    end
  end
  resources :tags

  get '/login', to: 'user_sessions#new', as: :login
  post '/login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  get '/sign_up', to: 'users#new', as: :sign_up
  post '/sign_up', to: 'users#create'
end
