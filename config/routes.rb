Rails.application.routes.draw do
  devise_for :users
  # get 'apply', to: 'applications#new', as: 'apply'
  root to: 'applications#new'
  resources :applications, only: [ :new ]
  resources :users
  resources :partners
  resources :amenities

  resources :rooms, only: [ :index ]

  resources :projects, only: [:show, :create, :destroy] do
    resources :steps, only: [:show, :update], controller: 'project/steps'
    resources :roomtypes, only: [:show, :index, :destroy]
  end

  resources :bookings, only: [ :new, :show, :create, :index ] do
    # resources :process, path: 'process/(:booking_auth_token)', only: [:show, :update], controller: 'booking/process'
    get 'send_booking_process_invite', to: 'booking/process#send_booking_process_invite', as: 'send_booking_process_invite'
  end

  post 'apply', to: 'booking/process#create'

  get 'fritz_all_users', to: 'users#all_users', as: 'all_users'
  resources :welcome_calls, only: [:index]
  patch 'change_attendance', to: 'welcome_calls#change_attendance', as: 'change_attendance'
  resources :bookings, path: 'bookings/(:booking_auth_token)', only: [] do
    resources :welcome_calls, only: [:new, :edit, :update, :destroy]
    patch 'welcome_calls', to: 'welcome_calls#create', as: 'create_welcome_calls'
    get 'projects', to: 'bookings#show', as: 'projects'

    get 'projects/:project_id/roomtypes/:roomtype_id/payment', to: 'bookings#show', as: 'payment'
    get 'projects/:project_id/roomtypes/:roomtype_id/contract', to: 'bookings#show', as: 'contract'
    get 'projects/:project_id/roomtypes/:roomtype_id', to: 'bookings#show', as: 'roomtype'
    get 'projects/:project_id/roomtypes', to: 'bookings#show', as: 'roomtypes'
    # resources :projects, only: [ :index ] do #only index, show was just for developing
    #   resources :roomtypes, only: [ :show, :index ]
    # end
    # get 'payment', to: 'payments#new', as: 'new_payment'
    # get 'contract', to: 'contracts#contract', as: 'contract'
    get 'success', to: 'bookings#success', as: 'success'

    # resources :projects, only: [:index] do
    #   resources :roomtypes, only: [:index]
    #   get 'roomtypes/:name', to: 'roomtypes#show', as: 'roomtype'
    # end
    # resources :contracts, only: [:new, :create, :show]
    # resources :payments, only: [:new, :create]
  end
  # get 'bookings/(:booking_auth_token)/:id/payment', to: 'bookings#payment', as: 'booking_payment'

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
      post 'pipedrive_webhook', to: 'webhooks#pipedrive_webhook'
      # resources :rooms, only: [ :index ]
      resources :applications, only: [ :create ]
      resources :projects, only: [ :show, :index ] do
        resources :roomtypes, only: [ :index ]
        # resources :amenities, only: [ :index ]
      end
      resources :amenities, only: [ :index ]
      resources :descriptions, only: [ :index ]
      resources :roomtypes, only: [ :show ]
      resources :bookings, path: 'bookings/(:booking_auth_token)', only: [ :index, :show, :update ] do
        resources :contracts, only: [ :index, :create ]
        # get 'success', to: 'bookings#show'
        get 'secret', to: 'payments#secret'
      end
      resources :contracts, only: [ :update ]
      resources :users, only: [ :index, :update ] do
        resources :bookings, only: [ :create ]
        resources :addresses, only: [ :create ]
      end
      resources :addresses, only: [ :update ]
    end

    namespace :v2 do
      resources :bookings, only: [ :update ] do
        resources :contracts, only: [ :create ]
        resources :payments, only: [ :new ]
        # get 'secret', to: 'payments#secret'
      end
      resources :projects, only: [ :index ] do
        resources :roomtypes, only: [ :index ]
      end
      resources :users, only: [:update] do
        resources :addresses, only: [ :create ]
      end
      post 'complete_booking', to: 'bookings#complete'
    end
  end
end
