Rails.application.routes.draw do
  resources :monitored_apis #erzeugt automatisch 7 routes

  root "monitored_apis#index"
end