angular.module('weixin.directives')
  .directive 'loadingContainer', [()->
    restrict: 'A'
    scope: false
    link: (scope, element, attrs)->
      loadingLayer = $('<div class="loading"></div>').appendTo(element)
      $(element).addClass('loading-container')
      scope.$watch attrs.loadingContainer, (value)->
        loadingLayer.toggle(value)
  ]