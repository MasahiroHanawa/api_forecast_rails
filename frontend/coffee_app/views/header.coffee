Cookie = require('../util/cookie.coffee')
Marionette = require('backbone.marionette')

Header = Marionette.LayoutView.extend(
  template: require('../templates/blog/header.pug'),
  initialize: ->
    cookie = Cookie()
    this.model.set(
      authorization: cookie['Authorization']
    )
  ui:
    home: '.home',
    blog: '.blog',
    logout: '.logout',
    login: '.login',
    signup: '.signup'
  events:
    'click @ui.home': 'show:home',
    'click @ui.signup': 'show:signup',
    'click @ui.login': 'show:login',
    'click @ui.logout': 'show:logout'
  triggers:
    'click @ui.blog': 'show:blog:list'
)

module.exports = Header