Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: 'pages#home'
  # Defines the root path route ('/')
  # root 'posts#index'

  get 'dashboard', to: 'pages#dashboard'
  get 'leaderboard', to: 'pages#leaderboard'
  get 'my_events', to: 'pages#user_events'
  get 'map', to: 'pages#map'
  get 'chatrooms', to: 'pages#chatrooms'

  resources :events do
    resources :participations, only: %i[create update destroy]
    get 'participations/:id', to: 'participations#cancel', as: :participation_cancel
    resources :messages, only: %i[index create]
  end

  resources :games, only: %i[index show]
  resources :favorites, only: %i[create destroy]
end
