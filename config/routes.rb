Rails.application.routes.draw do

  root to: 'default#index'

  resources :serials, only: [:index]
  resources :subscriptions, only: [:index, :create]
  delete '/subscriptions', to: 'subscriptions#delete'

  get '/auth/twitter/callback', to: 'auth/callback#twitter'
end
