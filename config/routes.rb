Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "static_pages/help"
    resources :microposts
    resources :users
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create)
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
