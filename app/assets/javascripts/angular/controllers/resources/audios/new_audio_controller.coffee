angular.module('weixin.controllers').controller 'NewAudioController', [
  '$rootScope', '$scope', 'BreadCrumbsService', 'fileUpload', 'Audio', '$location', ($rootScope, $scope, BreadCrumbsService, fileUpload, Audio, $location)->
    
    ################################
    # config
    ################################
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.resources.application.index')
      path: '/resources/audios'
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.resources.audios.new')
      path: '/resources/audios/new'
    
    ################################
    # $scope
    ################################
    $scope.isAddedFile = false
    $scope.isValidFile = false
    $scope.isUploadLoading = true
    $scope.usege = 80
    $scope.isLoading = true
    $scope.audio = new Audio
    $scope.uploadOptionsForFile = 
      # 10M
      maxFileSize: 10000000
      acceptFileTypes: /^audio\/(mp3)$/
      paramName: 'audio[file]'
      url: '/services/resources/audios'
      formData: []
      limitMultiFileUploads: 1
      messages:
        acceptFileTypes: I18n.t('errors.messages.fileupload.accept_file_types')
        maxFileSize: I18n.t('errors.messages.fileupload.max_file_size', {count: '5MB'})
        
    
    $scope.fileCancel = (file)->
      $scope.isAddedFile = false
      $scope.isValidFile = false
      file.$cancel()
      
    $scope.submitAudio = (form)->
      if form.$valid
        $scope.submit()
    
    $scope.isShowSubmitButton = (form)->
      if !$scope.isValidFile
        return true
      else
        return form.$invalid
    
    
    ################################
    # watchs
    ################################
    $scope.$watch 'queue.length', (newValue, oldValue)->
      error = []
      if newValue > 0 && $scope.isAddedFile
        angular.forEach $scope.queue, (value, key)->
          error.push value.error if !!value.error
        if error.length > 0
          $scope.isValidFile = false
        else
          $scope.isValidFile = true

    
    ################################
    # events
    ################################
    $scope.$on 'fileuploadadd', (e, data)->
      $scope.isAddedFile = true
      
    $scope.$on 'fileuploadsubmit', (e, data)->
      data.formData = 
        'audio[title]': $scope.audio.title
        'audio[description]': $scope.audio.description
    $scope.$on 'fileuploaddone', (e, data)->
      if !data.errors
        $rootScope.$state.transitionTo 'audios'
        $rootScope.$messenger.update
          message: I18n.t('views.messages.audios.success')
          type: 'success'
      else
        $rootScope.$messenger.update
          message: I18n.t('errors.messages.server_error')
          type: 'error'
    $scope.$on 'fileuploadfail', (e, data)->
      $scope.isValidFile = false
      $rootScope.$messenger.update
        message: I18n.t('errors.messages.server_error')
        type: 'error'
    
    ################################
    # private methods
    ################################
    
    ################################
    # run
    ################################
]