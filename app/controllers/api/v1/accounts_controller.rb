class Api::V1::AccountsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    binding.pry
    account = Account.new name: params[:name],
                       en_name: params[:en_name],
                          desc: params[:desc],
                        avatar: params[:avatar],
                       qr_code: params[:qr_code]
    respond_to do |format|
      if account.save
        format.json { render json: "{ result: { status: 'ok' } }" }
      else
        format.json { render json: "{ reuslt: { error: '#{account.errors.full_messages.join(',')}' } }" }
      end
    end
  end
end
