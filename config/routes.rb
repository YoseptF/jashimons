# frozen_string_literal: true

Rails.application.routes.draw do
  resources :mascots, only: %i[index create new]
  resource :config, only: %i[edit update edit]
  resource :user, only: %i[show]
  get "/commands", to: "commands#show", as: 'commands'
  post "/commands", to: "commands#edit"
  post '/set_main/:id', to: "mascots#set_main", as: 'set_main'
  get "/collection", to: "mascots#collection", as: 'collection'
  get "/:id/mainMascot", to: "mascots#main", as: 'main'
  post "/buy/:id", to: "mascots#buy", as: 'buy'
  get "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"
  get "/auth", to: "sessions#auth"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
