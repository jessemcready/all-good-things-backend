Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, except: [:edit]
      resources :comments, except: [:update, :edit]
      resources :posts, except: [:update, :edit]
      resources :likes, only: [:index, :create, :delete]
      resources :relationships, only: [:index, :create, :delete]

      post '/login', to: 'users#login'
    end
  end

end
