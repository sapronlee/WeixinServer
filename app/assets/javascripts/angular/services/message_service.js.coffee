angular.module('weixin.services').factory 'Message', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/weixin/messages'
    name: 'message'
  return resource
]