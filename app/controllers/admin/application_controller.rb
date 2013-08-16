class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_admin_user!
  after_filter :reset_last_captcha_code!
  add_breadcrumb :index, :admin_root_path

  def after_sign_out_path_for(resource_or_scope)
    admin_root_path
  end
end
