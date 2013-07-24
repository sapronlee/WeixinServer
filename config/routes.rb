WeixinServer::Application.routes.draw do
  captcha_route
  
  root to: 'home#index'
  
  devise_for :users, skip: [:registrations],
              path_names: { sign_in: :login, sign_out: :logout, password: :secret }, 
              controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }
              
  namespace :api, defaults: { format: :json }, constraints: { format: :json } do
    namespace :v1 do
    end
  end
end
