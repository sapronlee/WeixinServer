# encoding: utf-8
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
      resources :replies, only: [:index, :create, :update, :destroy] do
        post 'unique_number', on: :collection
      end
      resources :areas, only: [:index, :create, :update, :destroy] do
        get :list, on: :collection
      end
      resources :audios, only: [:create]
    end
    namespace :resources do
      resources :audios, only: [:index, :create]
      resources :article_groups, only: [:index] do
        resources :articles, only: [:create]
      end
    end
  end

  # normal routes
  captcha_route
  root to: 'home#index'
  
  # 这句必须放到最末尾
  match '*path', to: redirect('/')

end