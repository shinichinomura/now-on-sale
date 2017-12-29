Rails.application.routes.draw do
  root to: 'default#index'

  resources :serials, only: [:index]

  get '/auth/twitter/callback', to: 'auth/callback#twitter'
end
