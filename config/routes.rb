# frozen_string_literal: true

Rails.application.routes.draw do
  constraints subdomain: 'api' do
    scope module: 'api', defaults: { format: :json } do
      namespace :v1 do
        resources :sessions, only: %i[create destroy]
        resources :players, only: %i[create index show update]
        resources :matches, only: %i[create index]
        devise_for :players, skip: %i[sessions registrations passwords]
      end
    end
  end
end
