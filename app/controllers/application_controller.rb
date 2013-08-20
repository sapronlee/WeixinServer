class ApplicationController < ActionController::Base

  protect_from_forgery
  after_filter :reset_last_captcha_code!
  before_filter :authenticate_user!

end
