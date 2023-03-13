Rails.application.routes.draw do
  devise_for :controllers
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lists do
    resources :profiles, only: %i[new create]
    resources :insta_profiles, only: %i[new create]
    resources :twitter_profiles, only: %i[new create]

    get "/profile-added", to: "insta_profiles#profile_added"

    # When adding a new profile to a list, user has to choose between IG or Twitter
    get "/new/select", to: "pages#select_insta_or_twitter"
  end

  resources :profiles, only: :destroy
  resources :insta_profiles, only: :destroy
  resources :twitter_profiles, only: :destroy

  resources :posts, only: :create
  resources :insta_posts, only: :create
  resources :twitter_posts, only: :create

  get "/profile", to: "pages#profile"
  get '/favourites', to: "favourite_lists#show"

  resources :favourite_insta_posts, only: %i[create destroy]
  resources :favourite_twitter_posts, only: %i[create destroy]
end
