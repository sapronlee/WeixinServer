angular.module('weixin.resources')
  .factory 'Reply', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/weixin/replies'
      name: 'reply'
  
    resource.checkUniqueNumber = (reply)->
      resource.$post '/services/weixin/replies/unique_number',
        areaId: reply.areaId
        number: reply.number
    
    return resource
  ]