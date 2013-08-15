angular.module('weixin.resources')
  .factory 'Area', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/weixin/areas'
      name: 'area'
    resource.getAreas = ()->
      resource.$get '/services/weixin/areas/list'
    return resource
  ]