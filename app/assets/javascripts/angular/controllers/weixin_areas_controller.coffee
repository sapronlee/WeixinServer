angular.module('weixin.controllers').controller 'WeixinAreasController', ['$scope', 'Area', 'ngTableParams', '$routeParams', 'BreadCrumbsService', 'alertService', '$dialog', ($scope, Area, ngTableParams, $routeParams, BreadCrumbsService, alertService, $dialog)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.application.index')
    path: '/'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.areas.index')
    path: '/#/weixin/areas'

  $scope.area = new Area
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
          $scope.areas = data.result.areas
          $scope.tableParams.total = data.result.areas_count
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
          $scope.alerts.push(
            type: 'success'
            message: 'Add Area Success!'
          )
          window.location = '#weixin/areas'
        (error)->
      )

  $scope.update = (form)->
    if form.$valid
      $scope.area.update().then(
        (data)->
          $scope.alerts.push(
            type: 'success'
            message: 'Add Area Success!'
          )
          window.location = '#weixin/areas'
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

  $scope.openMessageBox = (id)->
    title = 'Destory';
    msg = 'desoty area: '+ $scope.areas[id].name + '?';
    btns = [{result: false, label: 'Cancel'}, {result: true, label: 'OK', cssClass: 'btn-primary'}];
    $dialog.messageBox(title, msg, btns)
      .open()
        .then((result)->
          if result == true
            new Area($scope.areas[id]).delete().then(
              (data)->
                if data.result = true
                  $scope.alerts.push(
                    type: 'success'
                    message: 'Destory Area Success!'
                  )
                  $scope.init()
            )
        );
]