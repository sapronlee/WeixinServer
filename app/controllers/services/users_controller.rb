class Services::UsersController < Services::ApplicationController
  
  def require_current_user
  end
  
  def account
    @account = current_user.account
  end
  
end
