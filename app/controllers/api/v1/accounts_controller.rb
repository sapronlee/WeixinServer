class Api::V1::AccountsController < Api::ApplicationController

  before_filter :authentication_token, only: [:update, :destroy, :status]

  # method: post
  # url: api/v1/account
  # params: name, en_name, token, desc, avatar, qr_code
  # result: message, private_token
  # 创建微信公众帐号
  def create
    @account = Account.new params[:account]
    if @account.save
      respond_with(@account), status: 201
    else
      render 'error', status: 400
    end
  end

  def update
  end

  def destroy
  end

  # 获取帐号的锁定状态
  def status
    respond_with(@account), status: 200
  end

  private
  def authentication_token
    @account = Account.where(private_token: params[:id]).first
    if @account.blank?
      @account = Account.new
      @account.errors.add(:private_token, "invalid")
      render 'error', status: 401
    end
  end
end
