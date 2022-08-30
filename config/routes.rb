Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "items#index"

  resources :items, only: [:index, :show]
  resource :cart, only: [:show, :update, :destroy]
end
