angular.module('weixin.services').service 'Session', [
  'User', (User)->
    _private =
      cookieName: '1tripWeixinServer'
      isLogin: false
      _currentUser: {}
      _currentAccount: {}
           
    this.initCurrentUser = ()->
      User.currentUser().then(
        (data)->
          _private.currentUser = data.result
          _private.currentAccount = _private.currentUser.account
      )

    this.currentUser = _private._currentUser
    this.currentAccount = _private._currentAccount
    return
]