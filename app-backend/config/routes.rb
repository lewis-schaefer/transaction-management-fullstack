Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/ping', to: 'ping#show', format: :json, as: :ping

  namespace :api do
    namespace :v1 do
      resources :accounts, only: [:show]
      resources :transactions, only: [:index, :create]
    end
  end
end
