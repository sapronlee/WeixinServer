class Services::Resources::ArticleGroupsController < Services::Resources::ApplicationController
  
  def index
    
  end
  
  def show
    @article_group = ArticleGroup.find params[:id]
  end
  
end
