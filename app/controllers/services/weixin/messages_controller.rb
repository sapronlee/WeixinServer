class Services::Weixin::MessagesController < Services::Weixin::ApplicationController
  def index
    @messages = Message.ng_table params
  end
end
