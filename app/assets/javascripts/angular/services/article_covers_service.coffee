weixinService.factory 'ArticleCover', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/resources/article_covers'
    name: 'articleCover'
  return resource
]