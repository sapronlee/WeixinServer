angular.module('weixin.controllers').controller 'EditAudioController', [
  '$rootScope', '$scope', 'BreadCrumbsService', 'fileUpload', 'Audio', '$location', ($rootScope, $scope, BreadCrumbsService, fileUpload, Audio, $location)->
    
    ################################
    # config
    ################################
    BreadCrumbsService.add
      name: I18n.t('breadcrumbs.resources.audios.edit')
      path: '/resources/audios'
    
    ################################
    # $scope
    ################################
      
    ################################
    # watch
    ################################
    $scope.$on 'event:editAudio', (event, audio)->
      $scope.audio = audio
]