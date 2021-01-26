Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
    root to: 'static_pages#home'
    get 'static_pages/help'
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create)
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
