# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  scope :api do
    scope 'v1.0' do
      resources :restaurants, only: [:index, :show] do
          resources :reviews, only: [:index, :show, :create, :update,:destroy]
        end
      resources :cuisines, only: :index
      resources :reviews, only: [:index, :create, :destroy]
      post 'restaurants/:restaurant_id/rating', to: 'restaurants#averageRating', as: :average_restaurant_rating

    end
  end

  root 'pages#index'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV['SIDEKIQ_USERNAME'], ENV['SIDEKIQ_PASSWORD']]
  end
  mount Sidekiq::Web => '/sidekiq'

  scope :api do
    scope 'v1.0' do
      namespace :deliveries_manager do
        resources :deliveries, only: [:index, :show, :create]
      end
    end
  end
end
