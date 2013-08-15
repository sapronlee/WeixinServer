angular.module('weixin.controllers').controller 'HomeController', [
  '$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.home.index')
      path: '/'
]