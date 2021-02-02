Rails.application.routes.draw do


  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
    resources :account_activations, only: :edit
    root to: 'static_pages#home'
    get 'static_pages/help'
    get 'password_resets/new'
    get 'password_resets/edit'
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create)
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/account_activations", to: "account_activations#edit"
    resources :password_resets, only: [:new, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
