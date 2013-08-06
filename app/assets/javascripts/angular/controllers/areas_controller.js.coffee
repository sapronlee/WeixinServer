weixinController.controller 'areasController', ['$scope', 'Area', 'ngTableParams', '$routeParams', ($scope, Area, ngTableParams, $routeParams)->
  $scope.area = new Area
  $scope.alerts = []
  $scope.isNewArea = false
  $scope.isEditArea = false
  $scope.tableParams = new ngTableParams
    page: 1
    total: 0
    count: 10

  $scope.init = ()->
    $scope.$watch 'tableParams', (params)->
      $scope.loading = true
      Area.query(params.url()).then(
        (data)->
          $scope.loading = false
          $scope.areas = data.results
          $scope.tableParams.total = data.meta.total
        (error)->
      )

  $scope.newArea = ()->
    $scope.isNewArea = true
    $scope.area = new Area

  $scope.editArea = ()->
    Area.edit($routeParams.areaId).then(
      (data)->
        $scope.area = new Area(
          id: data.result._id
          name: data.result.name
        )
    )

  $scope.back = ()->
    $scope.isNewArea = false
    $scope.isEditArea = false

  $scope.create = (form)->
    if form.$valid
      $scope.area.create().then(
        (data)->
          # $scope.areas.unshift(
          #   new Area
          #     id: data.result.id
          #     name: data.result.name
          #     createAt: data.result.createAt
          # )
          # $scope.alerts.push
          #   type: 'Success: '
          #   message: 'Add a Area Success!'
          # $scope.back()
          window.location = '#areas'
        (error)->
      )

  $scope.update = (form)->
    if form.$valid
      $scope.area.update().then(
        (data)->
          window.location = '#areas'
      )

  $scope.closeAlert = (index)->
    $scope.alerts.splice(index, 1)

  $scope.checkName = (form)->
    if form.$valid && form.$dirty
      Area.unique(form.name.$viewValue).then(
        (data)->
          form.name.$setValidity 'unique', !data.result
      )

  $scope.changeName = (form)->
    form.name.$setValidity 'unique', true
]