dialogAlert = angular.module('dialogAlerts', [])

dialogAlert.factory 'alertService', ['$rootScope', ($rootScope)->
  $rootScope.alerts = []
]