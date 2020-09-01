Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit] do
        resources :merchant, only: [:index], module: :items
        # get '/merchant', to: 'merchant#show', module: :items
      end

      resources :merchants, except: [:new, :edit] do
        resources :items, only: [:index], module: :merchants
      end
    end
  end
end
