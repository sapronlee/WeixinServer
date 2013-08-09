WeixinServer::Application.routes.draw do

  # devise routes
  devise_for :users, skip: [:registrations],
              path_names: { sign_in: :login, sign_out: :logout, password: :secret },
              controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }

  # api routes
  namespace :api, defaults: { format: :json }, constraints: { format: :json } do
    namespace :v1 do
      resources :accounts, only: [:create, :update, :destroy] do
        post :status, on: :member
      end
    end
  end

  # angular services routes
  namespace :services, defaults: { format: :json }, constraints: { format: :json } do
    namespace :weixin do
      resources :replies, only: [:index, :create, :update, :destroy]
      resources :areas, only: [:index, :create, :update, :edit, :destroy] do
        get :check_name, on: :collection
      end
      resources :messages
    end
  end

  # normal routes
  captcha_route
  root to: 'home#index'

end