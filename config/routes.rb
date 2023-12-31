Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :restaurants, only: [:index, :show] do
    resources :items, only: [:show]
    resources :orders, only: [:create, :show]
    collection do
      get :quizz
    end
    post '/add_to_session_items', to: 'items#add_to_session', as: 'add_to_session_items'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
