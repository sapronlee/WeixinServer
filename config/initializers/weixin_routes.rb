module Weixin
  class Router
    # 支持以下形式
    # WeixinRouter.new(type: "text")
    # WeixinRouter.new(type: "text", content: "Hello2BusUser")
    # WeixinRouter.new(type: "text", content: /^@/)
    # WeixinRouter.new { |xml| xml[:MsgType] == 'image' }
    # WeixinRouter.new(type: "text") { |xml| xml[:Content].starts_with? "@" }
    def initialize(type, options = {}, &block)
      @type = type.to_sym
      @content = options[:content] if options[:content]
      @constraint = block if block_given?
    end

    def matches?(request)
      xml = request.params[:xml]
      result = true
      result = result && (xml[:MsgType].to_sym == @type) if @type
      result = result && (xml[:Content] =~ @content) if @content.is_a? Regexp
      result = result && (xml[:Content] == @content) if @content.is_a? String
      result = result && @constraint.call(xml) if @constraint
      return result
    end
  end
  
  module ActionController
    # 辅助方法，用于简化操作，weixin_request.content 比用hash舒服多了，对不？
    def weixin_request
      @weixin_request ||= WeixinRequest.new(params[:xml])
      return @weixin_request
    end

    class WeixinRequest
      attr_accessor :content, :type, :from_user, :to_user, :pic_url
      def initialize(hash)
        @content = hash[:Content]
        @type = hash[:MsgType]
        @from_user = hash[:FromUserName]
        @to_user = hash[:ToUserName]
        @pic_url = hash[:PicUrl]
      end
    end
  end
end

ActionController::Base.class_eval do
  include ::Weixin::ActionController
end

ActionView::Base.class_eval do
  include ::Weixin::ActionController
end