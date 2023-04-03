Rails.application.routes.draw do
  resources :leases
  resources :apartments
  resources :tenants
  resources :leases, only: [:index, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
