angular.module('weixin.resources')
  .factory 'User', ['railsResourceFactory', (railsResourceFactory)->
    resource = railsResourceFactory
      url: '/services/users'
      name: 'user'

    resource.currentUser = ()->
      resource.$post '/services/users/require_current_user'
    
    resource.prototype.getAccount = ()->
      resource.$get '/services/users/account'

    return resource
  ]