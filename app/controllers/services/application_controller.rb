class Services::ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!
  respond_to :json
  
  layout 'application'
  
end
