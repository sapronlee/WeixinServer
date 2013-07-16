window.weixinDirective.directive 'ngBlur', ['$parse', ($parse)->
  (scope, element, attr)->
    fn = $parse(attr['ngBlur'])
    element.on 'blur', (event)->
      scope.$apply ()->
        fn scope,
          $event: event
]