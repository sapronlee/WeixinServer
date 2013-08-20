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
    $scope.audio = new Audio
    $scope.isLoading = false
    $scope.isListView = true
    $scope.isEditView = $scope.isNewView = false
    $scope.tableParams = new ngTableParams
      page: 1
      total: 0
      count: 10
      sorting: 
        created_at: 'desc'
        
    $scope.editAudio = (audio, form)->
      $scope.isListView = false
      $scope.isEditView = true
      $rootScope.$broadcast('event:editAudio', audio)
    
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
            angular.forEach data.result.audios, (value, key)->
              $scope.audios.push new Audio(value)
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