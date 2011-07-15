Partay::Application.routes.draw do
  root to: 'events#index'
  resources :events
  resource :account

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_in', to: 'sessions#new', as: 'sign_in'
  match '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  match '/:id', to: 'pages#show', as: 'page'
end
