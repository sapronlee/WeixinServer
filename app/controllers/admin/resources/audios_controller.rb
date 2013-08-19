class Admin::Resources::AudiosController < Admin::ApplicationController
  add_breadcrumb :index, :admin_resources_audios_path
  before_filter :find_audio, only: [:edit, :update, :destroy]

  def index
    @audios = Audio.page(params[:page]).per(10)
  end

  def new
    add_breadcrumb :new
  end

  def create
    @audio = Audio.new params[:audio]
    if @audio.save
      redirect_to admin_resources_audios_path, notice: t('messages.account.success')
    else
      add_breadcrumb :new
      render :new
    end
  end

  def edit
    add_breadcrumb :edit
  end

  def update
    if @audio.attributes params[:audio]
      redirect_to admin_resources_audios_path, notice: t('messages.account.success')
    else
      render :edit
    end
  end

  def destroy
    if @audio.destroy
      redirect_to admin_resources_audios_path, notice: t('messages.account.success')
    else
      redirect_to admin_resources_audios_path, alert: t('messages.account.error')
    end
  end

  private
  def find_audio
    @audio = Audio.where(id: params[:id]).first
  end

end
