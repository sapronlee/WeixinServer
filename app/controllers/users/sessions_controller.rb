class Users::SessionsController < Devise::SessionsController
  
  layout 'blank'
  
  def create
    if valid_captcha?(params[:user][:captcha])
      super
    else
      build_resource
      flash[:error] = t('devise.failure.captcha_error')
      # clear captcha
      resource.captcha = ''
      respond_with_navigational(resource) { render :new }
    end
  end
  
end
