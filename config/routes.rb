Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/find', to: 'search#show'
        get '/:id/merchant', to: 'merchant#show'
      end

      resources :merchants, except: [:new, :edit] do
        resources :items, only: [:index], module: :merchants
      end

      resources :items, except: [:new, :edit]
    end
  end
end
