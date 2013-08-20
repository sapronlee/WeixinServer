angular.module('weixin.controllers').controller 'HomeController', [
  '$rootScope', '$scope', 'BreadCrumbsService', ($rootScope, $scope, BreadCrumbsService)->
    
    ################################
    # config
    ################################
    
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.home.index')
      path: '/'
      
    ################################
    # $scope
    ################################
    
    $scope.alerts = []
    $scope.currentUser = $rootScope.$currentUser
    
    ################################
    # watch
    ################################
    
    ################################
    # private methods
    ################################

    initController = ()->
      checkAccount()
     
    checkAccount = ()->
      if angular.isUndefined $scope.currentUser.accountId
        $scope.alerts.push
          type: 'info'
          title: I18n.t('views.titles.alert')
          content: I18n.t('views.messages.accounts.empty')
          
    ################################
    # run
    ################################

    initController()
]