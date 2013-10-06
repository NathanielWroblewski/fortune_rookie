FortuneRookie::Application.routes.draw do
  root to: 'users#show'
  devise_for :users

  resources :buys, only: [:new, :create]
  resources :players, only: [:index, :show]
  resources :sells, only: [:new, :create]
  resources :users, only: :show

  get '/buys/new/:id', to: 'buys#new'
  get '/sells/new/:id', to: 'sells#new'
  get '/services/:id', to: 'services#player_stats'
end
