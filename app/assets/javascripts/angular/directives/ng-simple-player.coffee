angular.module('weixin.directives')
  .directive 'ngSimplePlayer', [()->
    restrict: 'A'
    scope: false
    replace: true
    link: (scope, element, attrs)->
      $(element).player()
  ]