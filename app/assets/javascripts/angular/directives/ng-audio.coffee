angular.module('weixin.directives')
  .directive 'ngAudio', ['$timeout', ($timeout)->
    restrict: 'A'
    scope: false
    replace: true
    link: (scope, element, attrs)->
      audiojs.events.ready ()->
        audio = audiojs.create element,
          preload: false
        scope.$watch attrs.src, (newValue, oldValue)->
          audio[0].load newValue
  ]