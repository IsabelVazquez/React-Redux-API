Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create]
      post '/signin', to: 'sessions#create'
      post '/like', to: 'images#create'
      post '/votes', to: 'images#votes'
      post '/images', to: 'images#index'
      get '/galleries', to: 'images#galleries'
    end
  end
end
