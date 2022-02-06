Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  resources :tweets do
    resources :likes
  end
  resources :tweets do
    resources :tweets
  end
  resources :users

  root to: "tweets#index"

  # <api>
  # GWT |POST /api/article GET | PUT | DELETE
  namespace :api do
    resources :users do
      resources :tweets do
        resources :tweets
      end
    end
    resources :tweets do
      resources :tweets
    end
    resources :tweets, except: %i[new edit] do
      resources :likes, only: :create
    end
    resources :likes, only: :destroy

    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end

end
