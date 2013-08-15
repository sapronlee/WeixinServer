weixinController.controller 'NewArticleController', ['$window', '$q', '$scope', 'BreadCrumbsService', 'fileUpload', '$modal', 'Article', 'ArticleCover', ($window, $q, $scope, BreadCrumbsService, fileUpload, $modal, Article, ArticleCover)->
  # 设置Breadcrumbs
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.application.index')
    path: '/#/resources/articles'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.articles.index')
    path: '/#/resources/articles'
  BreadCrumbsService.add
    name: I18n.t('breadcrumbs.resources.articles.new')
    path: '/#/resources/articles/new'
    
  Messenger.options = 
    extraClasses: 'messenger-fixed messenger-on-top'
    theme: 'block'
    maxMessages: 1
    
  ################################
  # 局部变量
  ################################
  
  $scope.isAddedOfCover = false
  $scope.isValidOfCover = false
  $scope.article = new Article
  $scope.articles = []
  $scope.articleCover = new ArticleCover
  
  $scope.uploadOptionsForCover = 
    # 5M
    maxFileSize: 5000000
    loadImageMaxFileSize: 5000000
    acceptFileTypes: /^image\/(gif|jpeg|png)$/
    fileInput: $('#article-cover')
    paramName: 'article_cover[file]'
    url: '/services/resources/article_covers'
    formData: []
    limitMultiFileUploads: 1
    autoUpload: true
    disableImageResize: true
    messages:
      acceptFileTypes: I18n.t('errors.messages.fileupload.accept_file_types')
      maxFileSize: I18n.t('errors.messages.fileupload.max_file_size', {count: '5MB'})
  
  ################################
  # 监听
  ################################
  
  $scope.$on 'fileuploadadd', (e, data)->
    $scope.isAddedOfCover = true
    $scope.isValidOfCover = true
      
  $scope.$on 'fileuploaddone', (e, data)->
    if data.result.errors
      data.files[0].error = data.result.errors[0]
    else
      Messenger().post
        message: I18n.t('views.messages.articles.success_upload_article_cover')
        type: 'success'
        hideAfter: 3
      $scope._processCoverResult(data)
  
  ################################
  # 方法
  ################################
  
  $scope.init = ()->
    
  $scope.submitArticle = (form)->
    $scope.article.save().then(
      (data)->
        $scope.article.articleGroupId = $scope.articleGroupId = data.result.articleGroup.id
        if data.errors
          Messenger().post
            message: data.errors[0]
            type: 'error'
            hideAfter: 3
        else
          Messenger().post
            message: I18n.t('views.messages.articles.success_create_article')
            type: 'success'
            hideAfter: 3
          $scope.articles.push $scope.article
          $scope._resetArticle(form)
      (error)->
        Messenger().post
          message: I18n.t('errors.messages.server_error')
          type: 'error'
          hideAfter: 3
    )
    
  $scope.fileUplaodCancel = (file)->
    $scope.isAddedOfCover = false
    $scope.isValidOfCover = false
    file.$cancel()
  
  $scope.fileUploadDestroy = ()->
    $scope.articleCover.remove().then(
      (data)->
        Messenger().post
          message: I18n.t('views.messages.articles.success_destroy_article_cover')
          type: 'success'
          hideAfter: 3
        $scope.isAddedOfCover = false
        $scope.isValidOfCover = false
        # 清空上传列队
        $scope.clear($scope.queue)
        $scope.article.articleCoverId = ''
        $scope.articleCover.url = ''
    )
    
  $scope.isShowSubmitButton = (form)->
    if !$scope.isValidOfCover
      return true
    else
      return form.$invalid
  
  $scope._processCoverResult = (data)->
    angular.forEach data.result.result, (value, key)->
      $scope.articleCover[key] = value
    if $scope.article.master
      $scope.articleCover.url = $scope.articleCover.big_file
    else
      $scope.articleCover.url = $scope.articleCover.small_file
    $scope.article.articleCoverId = $scope.articleCover.id
  
  $scope._resetArticle = (form)->
    $scope.article = new Article
    $scope.article.articleGroupId = $scope.articleGroupId
    $scope.clear($scope.queue)
    $scope.isAddedOfCover = false
    $scope.isValidOfCover = false
    # 重置表单
    form.title.$pristine = true
    form.description.$pristine = true
    form.url.$pristine = true
    form.content.$pristine = true
    form.title.$dirty = false
    form.description.$dirty = false
    form.url.$dirty = false
    form.content.$dirty = false
]