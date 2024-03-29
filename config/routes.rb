Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # get "/vehicles" => "vehicles#index", as: :vehicles
  get '/vehicles/search', to: 'vehicles#search', as: 'vehicles_search'

  resources :vehicles do
    resources :bookings, only: [:new, :create, :show] do
      resources :reviews
    end
    resources :provider_bookings, only: [:update]
  end

  resources :bookings, only: [:index, :update]

end
