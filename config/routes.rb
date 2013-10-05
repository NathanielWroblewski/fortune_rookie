FortuneRookie::Application.routes.draw do
  root to: 'users#show'
  devise_for :users

  resources :users, only: :show
end
