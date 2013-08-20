angular.module('weixin.controllers').controller 'MusicUploadController', ['$q', '$scope', '$rootScope', 'fileUpload', '$modal', 'Audio', ($q, $scope, $rootScope, fileUpload, $modal, Audio)->
  $scope.isAdded = false
  $scope.musicIsValid = false
  $scope.audio = new Audio
  
  $scope.dialogModal = $modal
    template: '/assets/commons/dialog_modal.html'
    persist: true
    show: false
    keyboard: false
    backdrop: 'static'
    scope: $scope
  
  $scope.musicUploadOptions = 
    # 10M
    maxFileSize: 10000000
    acceptFileTypes: /^audio\/(mp3)$/
    fileInput: $('#audio_file')
    paramName: 'audio[file]'
    url: '/services/weixin/audios'
    messages:
      acceptFileTypes: I18n.t('errors.messages.fileupload.accept_file_types')
      maxFileSize: I18n.t('errors.messages.fileupload.max_file_size', {count: '10MB'})
  
  $scope.$on 'fileuploadadd', (e, data)->
    $scope.isAdded = true
    $scope.musicIsValid = true
    
  $scope.$on 'fileuploadsubmit', (e, data)->
    # 重新格式化上传数据
    data.formData = 
      'audio[title]': $scope.audio.title
      'audio[description]': $scope.audio.description
      
  $scope.$on 'fileuploaddone', (e, data)->
    if data.result.error
      # fileupload error
      $q.when $scope.dialogModal
        .then (element)->
          element.modal('show')
          $scope.errorMessages = data.result.error
          $scope.errorTitle = I18n.t('views.messages.error_title')
          $scope.resetAudio()
          $scope.modalClose()
    else
      # fileupload success
      $scope.audio = data.result.result
      $scope.$emit 'audioUploadSuccess', $scope.audio

  $scope.fileCancel = (file)->
    $scope.isAdded = false
    $scope.musicIsValid = false
    file.$cancel()
  
  $scope.uploadMusic = (form)->
    $scope.submit()
    
  $scope.showUploadButton = (form)->
    if !$scope.musicIsValid
      return true
    else
      return form.$invalid
  
  $scope.modalClose = ()->
    $scope.$parent.modalClose()
    
  $scope.resetAudio = ()->
    angular.forEach $scope.queue, (value, key)->
      value.$cancel()
    $scope.isAdded = false
    $scope.musicIsValid = false
    $scope.audio = new Audio
]