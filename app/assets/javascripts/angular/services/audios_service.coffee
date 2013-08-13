weixinService.factory 'Audio', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/weixin/audios'
    name: 'audio'
  return resource
]