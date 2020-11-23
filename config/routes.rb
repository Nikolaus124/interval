Rails.application.routes.draw do
  root "spaces#new"

  resources :spaces


  #get "doctors/schedule" => "doctors#schedule"
  get "doctors/all" => "doctors#show"
  resources :doctors

  get "patients/index" => "patients#index"
  get "patients/new" => "patients#new"
  resources :patients
end
