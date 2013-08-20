angular.module('weixin.directives')
  .directive 'fileUploadContainer', [()->
    restrict: 'A'
    scope:
      member: '=count'
    template: '<div class="fileupload-progress" data-file-upload-progress="progress()">' +
      '<div class="easy-pie-chart percentage" data-percent="{{member}}">' +
        '<span class="percent">{{member}}</span>' +
        '<span>%</span>' +
      '</div>' +
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
        $('.easy-pie-chart', element).easyPieChart(options)
      scope.$watch attrs.count, (newValue, oldValue)->
        $('.easy-pie-chart', element).data('easyPieChart').update(newValue)
      , true
  ]