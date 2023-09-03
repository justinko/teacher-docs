Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/healthz", to: proc { [200, {}, ["success"]] }

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :documents, only: [:index, :show, :create, :destroy]
  root "documents#index"
end
