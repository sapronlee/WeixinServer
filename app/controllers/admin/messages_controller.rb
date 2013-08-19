class Admin::MessagesController < Admin::ApplicationController
  add_breadcrumb :index, :admin_messages_path
  def index
    @messages = Message.page(params[:page]).per(10)
  end

  def show
    add_breadcrumb :show
    @message = Message.where(id: params[:id]).first
    @content = ActiveSupport::JSON.decode(@message.content)
  end
end
