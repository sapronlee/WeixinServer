angular.module('weixin.controllers').controller 'MessagesController', [
  '$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.weixin.application.messages')
      path: '/messages'
]