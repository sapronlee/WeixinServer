class Admin::AreasController < Admin::ApplicationController
  def index
    @areas = Area.page(params[:page]).per(10)
  end
end
