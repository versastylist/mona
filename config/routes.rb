Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: :show do
    resources :questionnaires, only: [:new, :create]
    resources :answers, only: [:create, :edit, :update]
  end

  resources :client_registrations, only: [:show, :new, :create]
  resources :services, only: :index
end
