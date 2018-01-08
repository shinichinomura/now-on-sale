Rails.application.routes.draw do
  root to: 'default#index'

  resources :serials, only: [:index]
  resources :subscriptions, only: [:index, :create]
  delete '/subscriptions', to: 'subscriptions#delete'
  resources :service_worker_push_subscriptions, only: [:create]

  get '/auth/twitter/callback', to: 'auth/callback#twitter'
  get '/logout', to: 'sessions#destroy'
end
