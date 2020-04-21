# frozen_string_literal: true

Rails.application.routes.draw do
  resources :mascots, only: %i[index create new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
