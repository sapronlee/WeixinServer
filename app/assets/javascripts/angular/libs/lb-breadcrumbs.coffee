lbBreadCrumbs = angular.module('lbBreadcrumbs', [])

lbBreadCrumbs.factory 'BreadCrumbsService', ['$rootScope', '$location', ($rootScope, $location)->
  breadcrumbs = []
  breadcrumbsService = {}
  
  $rootScope.$on '$stateChangeStart', (event, current)->
    breadcrumbs = []
  
  breadcrumbsService.add = (data)->
    breadcrumbs.push(data)
    $rootScope.$broadcast('breadcrumbsRefresh')
    
  breadcrumbsService.getAll = ()->
    breadcrumbs
  
  return breadcrumbsService  
]

lbBreadCrumbs.directive 'lbBreadcrumbs', ['$location', 'BreadCrumbsService', ($location, BreadCrumbsService)->
  restrict: 'AE'
  templateUrl: '/assets/commons/breadcrumbs.html'
  replace: true
  scope: true
  compile: (tElement, tAttrs)->
    ($scope, $elem, $attr)->
      $scope.$on 'breadcrumbsRefresh', ()->
        $scope.breadcrumbs = BreadCrumbsService.getAll()
      $scope.redirectTo = (path)->
        $location.path(path)
]