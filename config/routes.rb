Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
    resources :users, only: %i(new create)
    resources :account_activations, only: :edit
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    resources :users do
        member do
            get :following, :followers
        end
    end
    root to: 'static_pages#home'
    get 'static_pages/help'
    get 'password_resets/new'
    get 'password_resets/edit'
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/account_activations", to: "account_activations#edit"
  end
end
