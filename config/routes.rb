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

  get "/manifest.json" => "service_worker#manifest"
  get "/service-worker.js" => "service_worker#service_worker"

  root "events#index"
end
