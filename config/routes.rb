Rails.application.routes.draw do
  resources :giveaways do
    member do
      post :pick_winners
    end
  end

  devise_for :users

  get "/health", to: "health#show"

  # Defines the root path route ("/")
  root "giveaways#new"
end
