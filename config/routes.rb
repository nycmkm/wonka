Rails.application.routes.draw do
  resources :giveaways do
    member do
      post :pick_winners
    end
  end

  resources :events, only: %i[index show] do
    collection do
      get :sync
    end

    member do
      get :sync_attendees
    end
  end

  devise_for :users

  get "/health", to: "health#show"

  root "events#index"
end
