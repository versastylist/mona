Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: :show
  resources :client_registrations, only: [:show, :new, :create]
  resources :services, only: :index
  resources :addresses, only: :create
end
