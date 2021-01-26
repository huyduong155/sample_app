Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'static_pages/help'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
