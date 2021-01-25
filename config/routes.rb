Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'static_pages/help'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end