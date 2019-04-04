Rails.application.routes.draw do
  root to: 'users#new'

  resources :partners, only: [:index, :show, :new, :create, :destroy]
  get 'partners/success', to: 'partners#success'

  get 'user/:id/:authentity_token_contract/rooms', to: 'contracts#rooms_show', as: 'contract_rooms_show'
  resources :flats do
    resources :rooms do
      get 'user/:user_id/:authentity_token_contract/room_detail_show', to: 'contracts#room_detail_show', as: 'contract_rooms_detail_show'
    end
  end

  resources :bookings, only: [:index, :show, :edit, :update, :destroy]

  get 'user/:user_id/contracts/:id/:authentity_token_contract', to: 'contracts#contract_pdf', as: 'contract_pdf'
  get 'user/:user_id/contracts/:id/:authentity_token_contract/payment', to: 'contracts#payment', as: 'contract_payment'


  devise_for :users, :controllers => { invitations: 'users/invitations', sessions: 'users/sessions', passwords: 'users/passwords', confirmations: 'users/confirmations' }, :skip => [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end
  resources :users
  get 'user/applicants', to: 'users#applicants', as: 'applicants_index'
  get 'user/success', to: 'users#success', as: 'users_success'
  get 'user/contract', to: 'users#contract'
  #get 'users/contract/:id/:authentity_token_contract', to: 'users#contract', as: 'contract'
  post 'users/send_invitation_for_contract_pages', to: 'users#send_invitation_for_contract_pages'
end

