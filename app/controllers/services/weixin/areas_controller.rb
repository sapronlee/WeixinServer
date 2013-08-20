class Services::Weixin::AreasController < Services::Weixin::ApplicationController

  before_filter :find_area, only: [:edit, :update, :destroy]

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
      render json: @area, root: :result
  end

  def update
    if @area.update_attributes params[:area]
      render json: @area, root: :result
    end
  end

  def destroy
    render json: @area.destroy, root: :result
  end

  def check_name
    @area = Area.where(name: params[:name]).first
    render json: { result: @area.present? }
  end
  
  def list
    @areas = Area.all
  end

  private
  def find_area
    @area = Area.where(id: params[:id]).first
  end
end
