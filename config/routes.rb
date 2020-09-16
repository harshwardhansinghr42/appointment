Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      # namespace :users, defaults: { format: 'json' } do

      # end
      devise_for :users
    end
  end
end
