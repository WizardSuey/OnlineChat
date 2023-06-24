Rails.application.routes.draw do
  root 'pages#home'

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "edit", to: "users#edit"
  patch "edit", to: "users#update"

  resources :rooms do
    resources :messages
  end

  get 'user/:id', to: 'users#show', as: 'user'
end