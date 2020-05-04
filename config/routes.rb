Rails.application.routes.draw do
  resources :articles
  devise_for :users
  root to: 'users#new'
  resources :users
  resources :partners
  resources :projects, except: [:index] do
    resources :rooms, except: [:index]
  end
  get 'fritz_all_users', to: 'users#all_users', as: 'all_users'
  resources :welcome_calls, only: [:index]
  resources :bookings, path: 'bookings/(:booking_auth_token)', only: [:update] do
    resources :welcome_calls, only: [:new, :edit, :update, :destroy]
    patch 'welcome_calls', to: 'welcome_calls#create', as: 'create_welcome_calls'
    resources :projects, only: [:index] do
      resources :roomtypes, only: [:index]
      get 'rooms/:name', to: 'rooms#show', as: 'room'
    end
    resources :contracts, only: [:new, :create, :show]
    resources :payments, only: [:new, :create]
  end
  get 'bookings/(:booking_auth_token)/:id/payment', to: 'bookings#payment', as: 'booking_payment'
  resources :bookings, only: [:index]
  # get 'bookings/calendar/(:room_name)', to: 'bookings#calendar', as: 'booking_calendar'

  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
