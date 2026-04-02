Rails.application.routes.draw do
  root "pages#index"

  # Static pages
  get "terms", to: "static#terms"
  get "privacy", to: "static#privacy"

  # Game
  get "game", to: "game#index"
  post "game/roll", to: "game#roll"
  post "game/move", to: "game#move"
  post "game/mission_complete", to: "game#mission_complete"

  # Stamps
  resources :stamps, only: [:index]

  # Devise
  devise_for :users, skip: [:passwords]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
