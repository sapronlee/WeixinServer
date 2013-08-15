angular.module('weixin.directives')
  .directive 'ngFocus', ['$parse', ($parse)->
    (scope, element, attr)->
      fn = $parse(attr['ngFocus'])
      element.on 'focus', (event)->
        scope.$apply ()->
          fn scope,
            $event: event
  ]