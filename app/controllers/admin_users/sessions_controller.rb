class AdminUsers::SessionsController < Devise::SessionsController

  layout 'blank'

  skip_before_filter :require_no_authentication, :only => [:new]

  def create
    if valid_captcha?(params[:admin_user][:captcha])
      super
    else
      build_resource
      flash[:error] = t('devise.failure.captcha_error')
      # clear captcha
      resource.captcha = ''
      respond_with_navigational(resource) { render :new }
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    admin_root_path
  end

end
