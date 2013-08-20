# encoding: utf-8
WeixinServer::Application.routes.draw do
  
  # devise routes
  devise_for :users, skip: [:registrations],
              path_names: { sign_in: :login, sign_out: :logout, password: :secret },
              controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }

  # weixin server routes
  namespace :api, defaults: { format: :xml }, constraints: { format: :xml } do
    namespace :v1 do
      resources :accounts, only: [:show]
      scope path: 'accounts/:id', via: :post do
        root to:'accounts#text', constraints: Weixin::Router.new(:text)
        root to:'accounts#image', constraints: Weixin::Router.new(:image)
        root to:'accounts#location', constraints: Weixin::Router.new(:location)
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
    end
    namespace :resources do
      resources :audios, only: [:index, :create]
      resources :article_groups, only: [:index, :show]
      resources :articles, only: [:create, :update, :destroy]
      resources :article_covers, only: [:create, :destroy]
    end
    resources :users, only: [] do
      post :require_current_user, on: :collection
      get :account, on: :collection
    end
  end

  # normal routes
  captcha_route
  root to: 'home#index'
  
  # 这句必须放到最末尾
  # match '*path', to: redirect('/')

end