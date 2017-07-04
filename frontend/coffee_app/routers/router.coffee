Marionette = require('backbone.marionette')
LayoutView = require('../views/layout.coffee')
PageList = require('../models/page.coffee')
Cookie = require('../util/cookie.coffee')

Controller = Marionette.Object.extend(
  initialize: ->
    @options.regionManager = new Marionette.RegionManager(
      regions:
        main: '#blog-hook'
    )
    @cookie = Cookie()
    initialData = @getOption('initialData')
    layout = new LayoutView(
      model: new PageList(initialData)
    )
    @getOption('regionManager').get('main').show(layout)
    @options.layout = layout
  home: ->
    layout = @getOption('layout')
    @cookie = Cookie()
    if (@cookie['Authorization'])
      layout.triggerMethod('show:home')
    else
      layout.triggerMethod('show:login')
  blogList: ->
    console.log('bloglist');
    layout = @getOption('layout')
    layout.triggerMethod('show:blog:list')
  blogEntry: (entry) ->
    layout = @getOption('layout')
    layout.triggerMethod('show:blog:entry', entry)
  login: ->
    layout = @getOption('layout')
    @cookie = Cookie()
    if (@cookie['Authorization'])
      layout.triggerMethod('show:home')
    else
      layout.triggerMethod('show:login')
  logout: ->
    document.cookie = 'Authorization='
    @cookie = Cookie()
    @cookie['Authorization'] = ''
    layout = @getOption('layout')
    layout.triggerMethod('show:login')
  signUp: ->
    layout = @getOption('layout')
    layout.triggerMethod('show:signup')
  signUpComplete: ->
    layout = @getOption('layout')
    layout.triggerMethod('show:signup:complete')
  signUpConfirm: (param) ->
    @param = param
    layout = @getOption('layout')
    layout.triggerMethod('show:signup:confirm', param)
)

Router = Marionette.AppRouter.extend(
  appRoutes:
    '': 'home',
    'blog/': 'blogList',
    'blog/:entry': 'blogEntry',
    'login/': 'login',
    'logout/': 'logout',
    'signup/': 'signUp',
    'signup/complete': 'signUpComplete',
    'signup/confirm?(confirmation_token=:confirmation_token)': 'signUpConfirm'
  ,
  initialize: ->
    @controller = new Controller(
      initialData: @getOption('initialData')
    )
)

module.exports = Router