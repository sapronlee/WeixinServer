# encoding: utf-8
WeixinServer::Application.routes.draw do

  devise_for :admin_users, skip: [:registrations],
              path: "admin",
              path_names: { sign_in: :login, sign_out: :logout, password: :secret },
              controllers: { sessions: 'admin_users/sessions', passwords: 'admin_users/passwords' }

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

  namespace :admin do
    root to: 'home#index'
    resources :users
    resources :areas
    resources :accounts
    resources :messages, only: [:index, :show]
    resources :replies
    namespace :resources do
      resources :audios, except: [:show]
      resources :article_groups, only: [:index, :show]
      resources :articles, only: [:create, :update, :destroy]
      resources :article_covers, only: [:create, :destroy]
    end
  end

  # normal routes
  captcha_route
  root to: 'home#index'
  resources :accounts
  resources :messages
  resources :replies
  namespace :resources do
    resources :audios
    resources :articles
  end

end