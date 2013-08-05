class Weixin::AreasController < ActionController::Base

  before_filter :find_area, only: [:edit, :update]
  def index
    @areas = Area.ng_table params
  end

  def create
    @area = Area.new params[:area]
    if @area.save
      render json: @area, root: :result
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.json { render json: @area, root: :result }
    end
  end

  def update
    if @area.update_attributes params[:area]
      respond_to do |format|
        format.json { render json: @area, root: :result }
      end
    end
  end

  private
  def find_area
    @area = Area.where(id: params[:id]).first
  end
end
