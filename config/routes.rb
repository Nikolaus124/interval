Rails.application.routes.draw do
  root "spaces#new"

  resources :spaces


  get "doctors/all" => "doctors#show"
  resources :doctors

  get "patients/new" => "patients#new"
  resources :patients
end
