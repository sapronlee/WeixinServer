class Services::Weixin::RepliesController < Services::Weixin::ApplicationController
  
  def index
    @replies = Reply.ng_table params
  end
  
end
