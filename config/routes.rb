Rails.application.routes.draw do
  resources :monitored_apis do
    post :check, on: :member
  end

  root "monitored_apis#index"
end
