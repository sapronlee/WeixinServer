class Admin::AccountsController < Admin::ApplicationController
  add_breadcrumb :index, :admin_accounts_path
  before_filter :find_account, only: [:edit, :update]

  def index
    @accounts = Account.includes(:user).page(params[:page]).per(10)
  end

  def new
    add_breadcrumb :new
  end

  def create
    @account = Account.new params[:account]
    if @account.save
      redirect_to admin_accounts_path, notice: t('messages.account.success')
    else
      add_breadcrumb :index, :new_admin_account_path
      render :new
    end
  end

  def edit
    add_breadcrumb :edit
  end

  def update
    if @account.update_attributes params[:account]
      redirect_to admin_accounts_path, notice: t('messages.account.success')
    else
      add_breadcrumb :edit, :edit_admin_account_path
      render :edit
    end
  end

  private
  def find_account
    @account = Account.where(id: params[:id]).first
  end
end
