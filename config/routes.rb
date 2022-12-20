Rails.application.routes.draw do
  resources :giveaways
  devise_for :users

  get "/health", to: "health#show"

  # Defines the root path route ("/")
  root "giveaways#new"
end
