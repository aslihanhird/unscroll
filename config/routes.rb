Rails.application.routes.draw do

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  devise_for :controllers
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lists do
    resources :profiles, only: %i[new create]

    get "/profile-added", to: "profiles#profile_added"

    # When adding a new profile to a list, user has to choose between IG or Twitter
    get "/new/select", to: "pages#select_insta_or_twitter"
  end

  get "lists/:id/refresh", to: "lists#refresh", as: "refresh_list"

  resources :profiles, only: :destroy

  resources :posts, only: %i[create show update]
  patch "posts/:id/read", to: "posts#read"

  get "/user_profile", to: "pages#profile"
  get '/favourites', to: "pages#favourites"
end
