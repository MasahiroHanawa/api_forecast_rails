Cookie = require('../util/cookie.coffee')
Marionette = require('backbone.marionette')
#template = require('../templates/blog/footer.pug')

Header = Marionette.LayoutView.extend(
  template: require('../templates/blog/footer.pug'),
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