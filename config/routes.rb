Rails.application.routes.draw do
  root to: 'applicants#new'
  resources :applicants, only: [:index, :new, :create]
  get 'applicants/success', to: 'applicants#success'
  patch 'applicants/invite', to: 'applicants#invite'

  resources :flats do
    resources :bookings, only: [:new, :show, :create, :destroy] do
    end
  end

  resources :flats do
    resources :bookings
  end

  devise_for :users, :controllers => { invitations: 'users/invitations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
