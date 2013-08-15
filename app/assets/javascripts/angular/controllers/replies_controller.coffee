angular.module('weixin.controllers').controller 'RepliesController', [
  '$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.weixin.application.replies')
      path: '/replies'
]