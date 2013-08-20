angular.module('weixin.services').factory 'Area', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/services/weixin/areas'
    name: 'area'
  resource.edit = (id)->
    resource.$get resource.url() + "/" + id + "/edit"
  resource.unique = (name)->
    resource.$get resource.url() + "/check_name", name: name
  return resource
]