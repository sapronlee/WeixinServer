WeixinServer::Application.routes.draw do
  get "areas/index"

  captcha_route
  root to: 'home#index'

  devise_for :users, skip: [:registrations],
              path_names: { sign_in: :login, sign_out: :logout, password: :secret },
              controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }

  namespace :api, defaults: { format: :json }, constraints: { format: :json } do
    namespace :v1 do
      resources :accounts, only: [:create, :update, :destroy] do
        post :status, on: :member
      end
    end
  end

  namespace :weixin do
    resources :areas do
      get :list,       on: :collection
      get :check_name, on: :collection
    end
    resources :accounts, only: [:index, :destroy]
  end

end