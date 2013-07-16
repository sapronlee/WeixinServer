# encoding: UTF-8

class WebConfig
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::AppSettings

  setting :app_name,                  default: '微信公众账号后台系统'
  setting :default_text_message,      default: '亲，我不知道你写的是什么！'
  setting :default_voice_message,     default: '亲，我不知道你说的是什么！'
  setting :default_image_message,     default: '亲，我看不懂这张图！'
  setting :default_video_message,     default: '亲，这段视频看不懂哦！'
  setting :default_link_message,      default: '亲，这个链接看不懂！'
  setting :default_location_message,  default: '亲，找不到这个位置的内容哦！'

end
