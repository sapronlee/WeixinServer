class Services::ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!, :find_current_account
  respond_to :json
  
  layout 'application'
  
  private
  def find_current_account
    @current_account = current_user.account
    return @error = [t('views.messages.accounts.not_found')] if @current_account.blank?
  end
  
  def current_account
    @current_account
  end
  
end
