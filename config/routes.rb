Rails.application.routes.draw do
  root to: 'default#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :serials, only: [:index, :show]
  resources :subscriptions, only: [:index, :create]
  delete '/subscriptions', to: 'subscriptions#delete'
  resources :service_worker_push_subscriptions, only: [:create]

  get '/push_notifications/:registration_id/shift', to: 'push_notifications#shift'
  get '/auth/twitter/callback', to: 'auth/callback#twitter'
  get '/logout', to: 'sessions#destroy'
  get '/settings', to: 'settings#index', as: 'settings'
  put '/twitter_notification_settings', to: 'twitter_notification_settings#update'
  put '/service_worker_push_notification_settings', to: 'service_worker_push_notification_settings#update'
end
