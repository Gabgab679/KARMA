Rails.application.routes.draw do
  get 'pages/home'
  get '/dashboard', to: "pages#dashboard"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "pages#home"

  resources :events do
    resources :participations, only: [:create, :update, :destroy] #new and edit views
  end

resources :games, only: [:index, :show] # index show
resources :favorites, only: [:index, :create, :destroy, :update] #index new and edit
end
