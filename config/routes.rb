Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :exchanges
  root 'exchanges#index'

  get 'test.csv', to: 'exchanges#csv_download'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
