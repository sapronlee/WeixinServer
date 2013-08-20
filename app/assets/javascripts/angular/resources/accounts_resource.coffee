angular.module('weixin.resources')
  .factory 'Account', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/accounts'
      name: 'account'
    return resource
  ]