weixinController.controller 'ResourceAudiosController', ['$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.application.index')
    path: '/resources/audios'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.audios.index')
    path: '/resources/audios'
]