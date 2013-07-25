class Api::V1::AccountsController < Api::ApplicationController

  before_filter :check_token, only: [:update, :destroy, :status]

  # method: post
  # url: api/v1/account
  # params: name, en_name, token, desc, avatar, qr_code
  # result: message, private_token
  # 创建微信公众帐号
  def create
    account = Account.new name: params[:name],
                       en_name: params[:en_name],
                          desc: params[:desc],
                        avatar: params[:avatar],
                       qr_code: params[:qr_code]
    if account.save
      render json: "{ \"result\": { \"account\": { \"token\": \"#{account.token}\" } } }"
    else
      render json: "{ \"reuslt\": { \"error\": \"#{account.errors.full_messages.join(',')}\" } }", status: 403
    end
  end

  def update
  end

  def destroy
  end

  # 获取帐号的锁定状态
  def status
    render json: "{ \"result\": { \"account\": { \"lock\": #{@account.lock} } } }"
  end

  private
  def check_token
    @account = Account.where(private_token: params[:id]).first
    if @account.blank?
      render json: "{ \"result\": { \"error\": \"token invalid\" } }", status: 403
    end
  end

end
