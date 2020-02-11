Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :test, only: [:index], defaults: { format: :json }
  root 'test#index'

  namespace :api do
    namespace :v1, format: :json do
      resources :coach_directory, only: [:index], controller: :coach_directory
    end
  end
end
