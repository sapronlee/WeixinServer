angular.module('weixin.resources')
  .factory 'Audio', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/resources/audios'
      name: 'audio'
    return resource
  ]