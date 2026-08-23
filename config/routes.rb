Rails.application.routes.draw do
  devise_for :admins

  root "home#index"
  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  resources :products, only: %i[index show], param: :id
  resources :categories, only: %i[index show], param: :id

  namespace :admin do
    root "dashboard#index"
    resources :products
    resources :categories
    resources :brands
    resources :site_settings, only: %i[index edit update]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

end
