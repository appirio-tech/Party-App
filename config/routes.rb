Partay::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'

  constraints Conference do
    root to: 'events#index'
    resources :events do
      member do
        get :approve
        post :attendance, to: 'attendances#create'
        get :attendance, to: 'attendances#show'
        delete :attendance, to: 'attendances#destroy'
        get :calendar
      end
    end
    resource :account
    resources :users

    match '/sign_in', to: 'sessions#new', as: 'sign_in'
    match '/sign_out', to: 'sessions#destroy', as: 'sign_out'

    match '/:id', to: 'pages#show', as: 'page'
  end

  constraints ->(req){ !Conference.matches?(req) && req.host == ENV['ADMIN_DOMAIN'] } do
    root to: 'conferences#index'
    resources :conferences

    resources :events do
      member do
        get :approve
      end
    end
  end
end
