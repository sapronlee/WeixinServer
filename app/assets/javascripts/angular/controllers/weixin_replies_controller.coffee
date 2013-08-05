weixinController.controller 'WeixinRepliesController', ['$scope', 'Reply', 'ngTableParams', 'BreadCrumbsService', ($scope, Reply, ngTableParams, BreadCrumbsService)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.application.index')
    path: '/'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.replies.index')
    path: '/#/weixin/replies'
  
  # 设置局部变量
  $scope.tableParams = new ngTableParams
    page: 1
    total: 0
    count: 10
    sorting: 
      name: 'asc'

  $scope.modalOptions = {
    backdropFade: true
    dialogFade:true
  }
      
  # 加载数据
  $scope.init = ()->
    $scope.$watch 'tableParams', (params)->
      $scope.loading = true
      Reply.query(params.url()).then(
        (data)->
          $scope.loading = false
          $scope.replies = data.result.replies
          $scope.tableParams.total = data.result.replies_count
        (error)->
      )
  
  $scope.init()
]