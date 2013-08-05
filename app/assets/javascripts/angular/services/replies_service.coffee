weixinService.factory 'Reply', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/weixin/replies'
    name: 'reply'
  return resource
]