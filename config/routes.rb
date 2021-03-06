Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :checkup_appointments, only: [:index, :update]
      devise_for :users
    end
  end
end
