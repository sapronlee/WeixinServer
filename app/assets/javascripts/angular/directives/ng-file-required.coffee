window.weixinDirective.directive 'ngFileRequired', [()->
  require: 'ngModel'
  link: (scope, element, attrs, model)->
    element.bind 'change', ()->
      scope.$apply ()->
        model.$setViewValue(element.val())
        model.$render
]