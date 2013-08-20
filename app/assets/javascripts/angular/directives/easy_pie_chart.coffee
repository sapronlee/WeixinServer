angular.module('weixin.directives')
  .directive 'easyPieChart', ['$timeout', ($timeout)->
    restrict: 'A'
    replace: true
    scope:
      number: '=easyPieChart'
    template: '<div class="easy-pie-chart percentage" data-percent="{{number}}">' +
      '<span class="percent">{{number}}</span>' +
      '<span>%</span>' +
    '</div>'
    link: (scope, element, attrs)->
      colorRange = ['#08c', '#e7912a', '#bacf0b', '#4ec9ce', '#ec7337', '#f377ab']
      lineWidth = attrs.easyPieChartLineWidth || 12
      size = attrs.easyPieChartSize || 100
      barColor = colorRange[scope.$parent.$index % 6] || '#08c'
      options = 
        'animate': 2000
        'scaleColor': false
        'lineWidth': lineWidth
        'lineCap': 'square'
        'size': size
        'barColor': barColor
        'trackColor': '#e5e5e5'
      attrs.$observe 'easyPieChart', ()->
        $(element).easyPieChart(options)
      scope.$watch attrs.easyPieChart, (newValue, oldValue)->
        scope.number = newValue
        $(element).data('easyPieChart').update(newValue)
      , true
  ]