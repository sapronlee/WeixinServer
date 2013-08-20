class Services::Resources::ArticlesController < Services::Resources::ApplicationController
  
  def create
    @article = Article.new params[:article]
    if @article.save
      @article
    else
      @error = @article.errors.full_messages
    end
  end
  
end
