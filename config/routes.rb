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
      resources :tweets, except: %i[new edit]
    end

end
