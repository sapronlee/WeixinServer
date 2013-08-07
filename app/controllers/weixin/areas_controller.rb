class Weixin::AreasController < ActionController::Base

  def index
    @areas = Area.ng_table params
  end
end
