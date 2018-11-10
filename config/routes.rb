Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, except: [:edit]
      resources :comments, except: [:update, :edit]
      resources :posts, except: [:update, :edit, :destroy]
      resources :likes, only: [:index, :create, :destroy]
      resources :relationships, only: [:index, :create]

      delete '/relationships', to: 'relationships#destroy'
      delete '/likes', to: 'likes#destroy'
      post '/login', to: 'auth#create'
      get '/flagged', to: 'posts#flagged'
    end
  end

end
