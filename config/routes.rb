FortuneRookie::Application.routes.draw do
  root to: 'users#show'
  devise_for :users

  resources :buys, only: [:new, :create]
  resources :players, only: [:index, :show]
  resources :users, only: :show

  get '/buys/new/:id', to: 'buys#new'
end
