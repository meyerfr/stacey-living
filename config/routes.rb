Rails.application.routes.draw do
  devise_for :users
  root to: 'booking/process#apply'
  resources :users
  get 'open_user_modal', to: 'users#open_user_modal', as: 'open_user_modal'
  resources :partners
  resources :amenities

  resources :rooms, only: [ :index ]

  resources :projects, only: [:show, :create, :destroy] do
    resources :steps, only: [:show, :update], controller: 'project/steps'
    resources :roomtypes, only: [:destroy]
  end

  resources :bookings, only: [:index] do
    resources :process, path: 'process/(:booking_auth_token)', only: [:show, :update], controller: 'booking/process'
    get 'send_booking_process_invite', to: 'booking/process#send_booking_process_invite', as: 'send_booking_process_invite'
  end
  get 'apply', to: 'booking/process#apply', as: 'apply'
  post 'apply', to: 'booking/process#create'

  get 'fritz_all_users', to: 'users#all_users', as: 'all_users'
  resources :welcome_calls, only: [:index]
  patch 'change_attendance', to: 'welcome_calls#change_attendance', as: 'change_attendance'
  resources :bookings, path: 'bookings/(:booking_auth_token)', only: [:update] do
    resources :welcome_calls, only: [:new, :edit, :update, :destroy]
    patch 'welcome_calls', to: 'welcome_calls#create', as: 'create_welcome_calls'
    # resources :projects, only: [:index] do
    #   resources :roomtypes, only: [:index]
    #   get 'roomtypes/:name', to: 'roomtypes#show', as: 'roomtype'
    # end
    resources :contracts, only: [:new, :create, :show]
    resources :payments, only: [:new, :create]
  end
  get 'bookings/(:booking_auth_token)/:id/payment', to: 'bookings#payment', as: 'booking_payment'
  post 'create_payment_intent', to: 'payments#create_payment_intent', as: 'create_payment_intent'


  # get 'bookings/calendar/(:room_name)', to: 'bookings#calendar', as: 'booking_calendar'

  get 'home', to: 'pages#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :rooms, only: [ :index ]
      resources :projects, only: [ :index ] do
        resources :roomtypes, only: [ :index ]
        resources :amenities, only: [ :index ]
      end
    end
  end
end
