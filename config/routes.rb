Rails.application.routes.draw do
  root to: 'users#new'

  devise_for :users, controllers: {
    invitations: 'users/invitations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }, :skip => [:registrations]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end

  resources :partners, only: [:index, :show, :new, :create, :destroy]
  get 'partners/success', to: 'partners#success'

  resources :bookings, only: [:index, :show, :edit, :update, :destroy] do
    # ContractPage 4 (Payment)
    get 'contracts/:contract_id/:authentity_token_contract/payment', to: 'contracts#payment', as: 'contract_payment'
    resources :payments, only: [:new, :create]
  end

  get 'contracts/:contract_id/:authentity_token_contract', to: 'contracts#show', as: 'contract'
  patch 'contracts/:contract_id/:authentity_token_contract', to: 'contracts#update', as: 'contract_update'

  resources :flats, except: :index do
    resources :rooms, only: [:new, :create, :edit, :update, :destroy]
  end


  resources :users do
    # FlatsPage (Flats#index)
    get 'flats/:authentity_token_contract', to: 'flats#index', as: 'flats'
    # ContractPage 1 (Rooms#index)
    get 'flats/:flat_id/rooms/:authentity_token_contract', to: 'rooms#index', as: 'rooms'
    # ContractPage 2 (Rooms#show)
    get 'flats/:flat_id/rooms/:room_id/:authentity_token_contract', to: 'rooms#show', as: 'room'
    # ContractPage 3 (Contract#new and Contract#create)
    get 'flats/:flat_id/rooms/:room_id/contracts/new/:authentity_token_contract', to: 'contracts#new', as: 'contract_new'
    post 'flats/:flat_id/rooms/:room_id/contracts/:authentity_token_contract', to: 'contracts#create', as: 'contract_create'

    post 'bookings/:authentity_token_contract', to: 'bookings#create', as: 'bookings_create'
  end

  patch 'users/:user_id/flats/:flat_id/rooms/:room_id/:authentity_token_contract', to: 'users#updateapplicant', as: 'update_applicant'
  patch 'bookings/:booking_id/payment/new', to: 'users#updateapplicantpayment', as: 'update_applicant_payment'


  get 'user/applicants', to: 'users#applicants', as: 'applicants_index'
  get 'user/success', to: 'users#success', as: 'users_success'
  get 'user/contract', to: 'users#contract'
  #get 'users/contract/:id/:authentity_token_contract', to: 'users#contract', as: 'contract'
  post 'users/send_invitation_for_contract_pages', to: 'users#send_invitation_for_contract_pages'
end

