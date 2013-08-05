# = require angular/angular
# = require angular/angular-locale_zh-cn

# = require angularjs/rails/resource
# = require angular/libs/ng-table
# = require angular/libs/ng-table-params
# = require angular/libs/ui-bootstrap-tpls-0.4.0
# = require angular/libs/ui-utils

# = require angular/services
# = require angular/controllers
# = require angular/directives
# = require angular/templates

window.weixin = angular.module('weixin', ['weixin.services', 'weixin.controllers', 'weixin.directives', 'weixin.templates', 'ngTable', 'ui.bootstrap', 'ui.utils'])

window.weixin.config ["$httpProvider", "$routeProvider", ($httpProvider, $routeProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName("csrf-token")[0].content
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
  $routeProvider.
    when('/areas', { templateUrl: 'weixin/areas.html' }).
    when('/areas/new', { templateUrl: 'weixin/areas/new.html' }).
    when('/areas/:areaId/edit', { templateUrl: 'weixin/areas/:areaId/edit.html'})
]
