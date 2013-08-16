class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user, only: [:edit, :update]
  add_breadcrumb :index, :admin_users_path
  def index
    @users = User.page(params[:page]).per(10)
  end

  def new
    add_breadcrumb :new
  end

  def edit
    add_breadcrumb :edit
  end

  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to admin_users_path
    else
      add_breadcrumb :new
      render :new
    end
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to admin_users_path
    else
      add_breadcrumb :edit
      render :edit
    end
  end

  private
  def find_user
    @user = User.where(id: params[:id]).first
  end
end
