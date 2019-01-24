Rails.application.routes.draw do
  root to: 'flats#index'
  resources :applicants, only: [:new, :create]
  get 'applicants/success', to: 'applicants#success'

  resources :flats do
    resources :bookings, only: [:new, :show, :create, :destroy] do
    end
  end

  resources :flats do
    resources :bookings
  end


  devise_for :users, controllers: { confirmations: 'confirmations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
