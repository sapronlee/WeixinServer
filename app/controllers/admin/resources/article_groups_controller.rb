class Admin::Resources::ArticleGroupsController < Admin::ApplicationController
  add_breadcrumb :index, :admin_resources_article_groups_path
  before_filter :find_article_group, only: [:edit, :update, :destroy, :show]
  def index
    @article_groups = ArticleGroup.page(params[:page]).per(10)
  end

  def new
    add_breadcrumb :new
  end

  def create
    @article_group = ArticleGroup.new params[:article_group]
    if @article_group.save
      redirect_to admin_resources_article_groups_path
    else
      add_breadcrumb :new
      render :new
    end
  end

  def edit
    add_breadcrumb :edit
  end

  def update
    if @article_group.update_attributes params[:article_group]
      redirect_to admin_resources_article_groups_path
    else
      add_breadcrumb :edit
      render :edit
    end
  end

  def destroy
    @article_group.destroy
  end

  def show
    add_breadcrumb :show
  end

  private
  def find_article_group
    @article_group = ArticleGroup.where(id: params[:id]).first
  end
end
