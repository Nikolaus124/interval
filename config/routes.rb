Rails.application.routes.draw do
  root 'spaces#index'
  resources :spaces

  resources :doctors
  get 'doctors/all' => 'doctors#show'

  resources :patients
  get 'patients/new' => 'patients#new'
end
