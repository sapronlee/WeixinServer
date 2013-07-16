# https://github.com/drapergem/draper/wiki/Using-Rails-Path-Helpers-in-Draper-Decorators-with-Grape
# https://github.com/nesquena/rabl/wiki/Using-Rabl-with-Grape

 module Grape
  class Endpoint
    include Rails.application.routes.url_helpers
    default_url_options[:host] = ::Rails.application.routes.default_url_options[:host]
  end
end

module Rabl
  class Engine
    include ActionView::Helpers::ApplicationHelper
    include ActionView::Helpers::NumberHelper 
    include Rails.application.routes.url_helpers
    default_url_options[:host] = ::Rails.application.routes.default_url_options[:host]
  end
end
