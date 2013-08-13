class Services::Weixin::RepliesController < Services::Weixin::ApplicationController
  
  def index
    @replies = Reply.ng_table params
  end
  
  def unique_number
    @reply = Reply.where(area_id: params[:reply][:area_id], number: params[:reply][:number])
  end
  
end
