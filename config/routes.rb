Rails.application.routes.draw do
  root to: 'applicants#new'
  resources :applicants, only: [:index, :new, :create, :destroy]
  get 'applicants/success', to: 'applicants#success'
  patch 'applicants/invite', to: 'applicants#invite'

  resources :partners, only: [:index, :show, :new, :create, :destroy]
  get 'partners/success', to: 'partners#success'

  resources :flats do
    resources :bookings, only: [:new, :show, :create, :destroy] do
    end
  end

  devise_for :users, :controllers => { invitations: 'users/invitations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit]
end
