weixinService.factory 'Area', ['railsResourceFactory', (railsResourceFactory)->
  resource = railsResourceFactory
    url: '/weixin/areas'
    name: 'area'
  resource.edit = (id)->
    resource.$get resource.url() + "/" + id + "/edit"
  return resource
]