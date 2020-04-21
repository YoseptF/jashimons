# frozen_string_literal: true

Rails.application.routes.draw do
  resources :mascots, only: %i[index create new]
  resource :config, only: %i[edit update edit]
  resource :user, only: %i[show] do
    resources :mascots, only: %i[index]
  end
  get "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"
  get "/auth", to: "sessions#auth"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
