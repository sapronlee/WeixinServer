weixinController.controller 'ResourceArticlesController', ['$scope', 'BreadCrumbsService', ($scope, BreadCrumbsService)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.application.index')
    path: '/resources/articles'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.articles.index')
    path: '/resources/articles'
]