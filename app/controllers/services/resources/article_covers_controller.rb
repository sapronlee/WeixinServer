class Services::Resources::ArticleCoversController < Services::Resources::ApplicationController
  
  def create
    @article_cover = ArticleCover.new params[:article_cover]
    if @article_cover.save
      @article_cover
    else
      @error = @article_cover.errors.full_messages
    end
  end
  
  def destroy
    @article_cover = ArticleCover.find params[:id]
    @article_cover.destroy
  end
  
end
