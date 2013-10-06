FortuneRookie::Application.routes.draw do
  root to: 'users#show'
  devise_for :users


  resources :users, only: :show
  resources :players, only: [:index, :show]

end
