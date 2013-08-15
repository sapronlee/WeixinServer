angular.module('weixin.resources')
  .factory 'ArticleGroup', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/resources/article_groups'
      name: 'articleGroup'
    return resource
  ]