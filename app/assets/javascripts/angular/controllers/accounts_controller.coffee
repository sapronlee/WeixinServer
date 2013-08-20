angular.module('weixin.controllers').controller 'AccountsController', [
  '$rootScope', '$scope', 'BreadCrumbsService', 'Account', ($rootScope, $scope, BreadCrumbsService, Account)->
    
    ################################
    # config
    ################################
    
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.weixin.application.accounts')
      path: '/accounts'

    ################################
    # $scope
    ################################
    
    $scope.currentUser = $rootScope.$currentUser
    $scope.account = new Account
    
    ################################
    # watch
    ################################
    
    ################################
    # private methods
    ################################

    initController = ()->
      $scope.currentUser.getAccount().then(
        (data)->
          angular.extend $scope.account, data.result
      )

    ################################
    # run
    ################################

    initController()
]