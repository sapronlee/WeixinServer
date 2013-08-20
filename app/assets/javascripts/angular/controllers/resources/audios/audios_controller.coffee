angular.module('weixin.controllers').controller 'AudiosController', [
  '$rootScope', '$scope', 'BreadCrumbsService', 'ngTableParams', 'Audio', ($rootScope, $scope, BreadCrumbsService, ngTableParams, Audio)->
    
    ################################
    # config
    ################################
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.resources.application.index')
      path: '/resources/audios'
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.resources.audios.index')
      path: '/resources/audios'
    
    ################################
    # $scope
    ################################
    $scope.audios = []
    $scope.isLoading = false
    $scope.tableParams = new ngTableParams
      page: 1
      total: 0
      count: 10
      sorting: 
        created_at: 'desc'
    
    ################################
    # watch
    ################################
    
    ################################
    # private methods
    ################################
    initController = ()->
      initTable()

    initTable = ()->
      $scope.$watch 'tableParams', (params)->
        $scope.isLoading = true
        Audio.query(params.url()).then(
          (data)->
            $scope.audios = data.result.audios
            $scope.tableParams.total = data.result.audios_count
            $scope.isLoading = false
          (error)->
            $scope.isLoading = false
        )
    ################################
    # run
    ################################
    initController()
]