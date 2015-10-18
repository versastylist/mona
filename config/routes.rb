Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/client_terms', as: :client_terms_of_service, to: "static#client_terms"
  get '/stylist_terms', as: :stylist_terms_of_service, to: "static#stylist_terms"
  get '/surveys/registration', as: :registration_survey, to: 'registration_surveys#show'

  resources :users, only: [:show, :index]
  resources :registrations, only: [:show, :new, :create, :update]
  resources :services, only: [:new, :create, :index]
  resources :payment_infos, only: [:new, :create]
  resources :schedules, only: [:new, :create]
  resources :order_items, only: [:create]
  resources :appointments, only: [:new, :create]
  resources :stylist_reviews, only: :create

  resources :service_menu_filters, only: :index, as: :menu_filters do
    resources :appointment_filters, only: [:index], as: :appointments
  end

  namespace :admin do
    resources :surveys, only: [:new, :create, :index, :show] do
      resources :questions, only: [:new, :create]
    end
  end

  resources :surveys, only: [:show] do
    resources :completions, only: :create
  end

  # This should remain towards bottom for pattern matching purposes
  get '/:id', as: :stylist, to: 'stylists#show'
end
