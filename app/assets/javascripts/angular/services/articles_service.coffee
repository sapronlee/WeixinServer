weixinService.factory 'Article', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/resources/articles'
    name: 'article'
  return resource
]