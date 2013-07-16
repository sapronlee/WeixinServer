class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :authenticate_user!
  after_filter :reset_last_captcha_code!
  add_breadcrumb :index, :root_path
  
end
