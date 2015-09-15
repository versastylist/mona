Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/client_terms', as: :client_terms_of_service, to: "static#client_terms"
  get '/stylist_terms', as: :stylist_terms_of_service, to: "static#stylist_terms"
  resources :users, only: :show
  resources :client_registrations, only: [:show, :new, :create]
  resources :services, only: :index
end
