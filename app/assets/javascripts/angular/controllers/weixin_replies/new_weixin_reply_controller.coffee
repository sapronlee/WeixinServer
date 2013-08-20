angular.module('weixin.controllers').controller 'NewWeixinReplyController', ['$scope', '$q', 'Reply', 'Area', 'BreadCrumbsService', '$modal', ($scope, $q, Reply, Area, BreadCrumbsService, $modal)->
  ################################
  # 配置
  ################################
  
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.replies.index')
    path: '/#/weixin/replies'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.weixin.replies.new')
    path: '/#/weixin/replies/new'
  
  ################################
  # 变量
  ################################
  
  $scope.areaInvalid = true
  $scope.checkNumberStatus = false
  $scope.isOpenModal = false
  $scope.reply = new Reply
  
  $scope.tabs = [
    {title: I18n.t('mongoid.enums.reply.msg_type.text'), template: '/assets/weixin/replies/_text_tab.html'}
    {title: I18n.t('mongoid.enums.reply.msg_type.news'), template: '/assets/weixin/replies/_news_tab.html'}
    {title: I18n.t('mongoid.enums.reply.msg_type.music'), template: '/assets/weixin/replies/_audio_tab.html'}
  ]
  
  $scope.musicModalService = $modal
    template: '/assets/weixin/replies/_audio_form.html'
    persist: true
    show: false
    keyboard: false
    backdrop: 'static'
    scope: $scope
  
  ################################
  # 监听
  ################################
  
  $scope.$watch 'reply.msgType', (newValue, oldValue)->
    $scope.previousTab = oldValue
    switch newValue
      when 0 then $scope.selectTextTab()
      when 1 then $scope.selectNewsTab()
      when 2 then $scope.selectMusicTab()
      
  $scope.$on 'modal-hidden', ()->
    $scope.isOpenModal = false
  
  $scope.$on 'modal-shown', ()->
    $scope.isOpenModal = true
    
  $scope.$on 'audioUploadSuccess', (event, audio)->
    console.log audio
  
  ################################
  # 方法
  ################################
  
  # 初始化area选择框
  $scope.initAreas = ()->
    $scope.reply.msgType = 0
    Area.getAreas().then(
      (data)-> $scope.areas = data.result.areas
      (error)->
    )
  
  # 全局初始化函数，加载时调用
  $scope.init = ()->
    $scope.initAreas()
    
  # 区域的change回调
  $scope.changeAreaSelect = (form)->
    if form.areaId.$dirty && form.areaId.$valid
      $scope.areaInvalid = false
    else
      $scope.areaInvalid = true
      $scope.reply.number = ''
  
  # 检查reply.number的验证方法
  $scope.checkUniqueNumber = (number)->
    if $scope.reply.number && number.$valid
      $scope.checkNumberStatus = true
      Reply.checkUniqueNumber($scope.reply).then(
        (data)->
          number.$setValidity 'unique', !data.result.reply
          $scope.checkNumberStatus = false
        (error)->
      )
  
  # 重置number
  $scope.resetCheckNumber = (number)->
    number.$setValidity 'unique', true
  
  $scope.selectTextTab = ()->
    $scope.requiredContent = true

  $scope.selectMusicTab = ()->
    $q.when $scope.musicModalService
      .then (element)->
        element.modal('show') if !$scope.isOpenModal

  $scope.selectNewsTab = ()->

  $scope.modalClose = ()->
    $q.when $scope.musicModalService
      .then (element)->
        element.modal('hide') if $scope.isOpenModal

    $scope.reply.msgType = $scope.previousTab
  
  $scope.init()
]