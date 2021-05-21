Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  post "/search", to: "articles#search"
  get "/search", to: "articles#search"
  post "/filter", to: "articles#filter"
  get "/filter", to: "articles#filter"
  resources :articles do
    resources :comments
  end
end
