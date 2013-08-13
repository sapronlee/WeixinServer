class Services::Weixin::AreasController < Services::Weixin::ApplicationController
  
  def index
    
  end
  
  def list
    @areas = Area.all
  end
  
end
