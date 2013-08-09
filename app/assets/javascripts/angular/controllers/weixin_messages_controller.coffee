weixinController.controller 'WeixinMessagesController', ['$scope', '$q', 'Message', 'ngTableParams', 'BreadCrumbsService', ($scope, $q, Message, ngTableParams, BreadCrumbsService)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.application.index')
    path: '/'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.messages.index')
    path: '/#/weixin/messages'

  $scope.alerts = []
  $scope.tableParams = new ngTableParams
    page: 1
    total: 0
    count: 10

  $scope.init = ()->
    $scope.$watch 'tableParams', (params)->
      $scope.loading = true
      Message.query(params.url()).then(
        (data)->
          $scope.messages = data.result.messages
          $scope.loading = false
        (error)->
      )


  $scope.types = ()->
    def = $q.defer()
    types = [{id: 0, title:'文本'},{id: 1, title:'图片'},{id:2, title:'地图位置'},{id:3, title:'链接'},{id:4, title: '事件'}]
    def.resolve(types)
    return def.promise

]