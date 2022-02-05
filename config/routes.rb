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

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
