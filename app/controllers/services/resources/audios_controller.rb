class Services::Resources::AudiosController < Services::Resources::ApplicationController
  
  def index
    @audios = current_account.audios.ng_table params
  end
  
  def create
    @audio = current_account.audios.new params[:audio]
    if @audio.save
      @audio
    else
      @error = @audio.errors.full_messages
    end
  end
  
end
