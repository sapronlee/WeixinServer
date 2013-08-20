class Services::Weixin::AudiosController < Services::Weixin::ApplicationController
  
  def create
    @audio = Audio.new params[:audio]
    if @audio.save
      @audio
    else
      @error = @audio.errors.full_messages
    end
  end
  
end
