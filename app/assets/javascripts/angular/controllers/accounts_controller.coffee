angular.module('weixin.controllers').controller 'AccountsController', [
  '$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.weixin.application.accounts')
      path: '/accounts'
]