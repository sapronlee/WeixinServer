# = require angular/libs/angular
# = require angular/libs/ng-cookies
# = require angular/libs/angular-locale_zh-cn

# = require angularjs/rails/resource
# = require ng-rails-csrf
# = require angular/libs/ng-table
# = require angular/libs/ng-table-params
# = require angular/libs/ui-bootstrap-tpls-0.4.0
# = require angular/libs/ui-utils
# = require angular/libs/angular-ui-router
# = require angular/libs/angular-strap
# = require angular/libs/lb-breadcrumbs
# = require angular/libs/jquery.fileupload

# = require_self

# = require angular/routes

# = require_tree ./angular/commons
# = require_tree ./angular/services
# = require_tree ./angular/directives
# = require_tree ./angular/filters
# = require_tree ./angular/resources
# = require_tree ./angular/controllers

angular.module 'weixin.services', []
angular.module 'weixin.directives', []
angular.module 'weixin.filters', []
angular.module 'weixin.resources', ['rails']
angular.module 'weixin.controllers', ['weixin.services']

angular.module 'weixin', [
  'weixin.services',
  'weixin.directives',
  'weixin.filters',
  'weixin.resources',
  'weixin.controllers',
  'weixin.directives',
  'ng-rails-csrf',
  'ngCookies',
  'ngTable',
  'ui.bootstrap',
  'ui.utils',
  'ui.router',
  'ui.state',
  '$strap.directives',
  'lbBreadcrumbs',
  'blueimp.fileupload'
]

angular.module('weixin').run ($rootScope, $location, $state, $stateParams, User)->
  
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
  $rootScope.$currentUser = new User
  User.currentUser().then(
    (data)->
      angular.extend $rootScope.$currentUser, data.result
  )
  $rootScope.$messenger = Messenger
    extraClasses: 'messenger-fixed messenger-on-top'
    theme: 'block'
    maxMessages: 1
  .post
    hideAfter: 3
  .hide()
  
  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->
    if toState.name isnt 'home' and angular.isUndefined $rootScope.$currentUser.accountId
      $location.path '/'

