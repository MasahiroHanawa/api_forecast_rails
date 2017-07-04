Marionette = require('backbone.marionette')
Backbone = require('backbone')
Header = require('./header.coffee')
Footer = require('./footer.coffee')
List = require('./list.coffee')
Blog = require('./blog.coffee')
Home = require('./home.coffee')
HomeModel = require('../models/home.coffee')
Login = require('./login.coffee')
Signup = require('./signup.coffee')
SignupComplete = require('./signupComplete.coffee')
UserModel = require('../models/user.coffee')
BlogList = require('../collections/blog.coffee')


LayoutView = Marionette.LayoutView.extend(
  template: require('../templates/blog/layout.pug')
  regions:
    header: '.header-hook'
    footer: '.footer-hook'
    layout: '.layout-hook'
  onShowBlogList: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    blogList = new BlogList(@model.get('pages').blog.posts)
    list = new List(
      collection: blogList
    )
    @showChildView('header', header)
    @showChildView('footer', footer)
    @showChildView('layout', list)
    Backbone.history.navigate('blog/')
  onShowBlogEntry: (entry) ->
    @collection = new BlogList(@model.get('pages').blog.posts)
    model = @collection.get(entry)
    @showBlog(model)
  onChildviewSelectEntry: (child, model) ->
    @showBlog(model)
  onChildviewShowBlogList: ->
    @triggerMethod('show:blog:list')
  onShowSignup: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    signup = new Signup()
    @showChildView('footer', header)
    @showChildView('header', footer)
    @showChildView('layout', signup)
    Backbone.history.navigate('signup/')
  onShowSignupComplete: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    signupComplete = new SignupComplete()
    @showChildView('footer', header)
    @showChildView('header', footer)
    @showChildView('layout', signupComplete)
    Backbone.history.navigate('signup/complete')
  onShowSignupConfirm: (param) ->
    @model.user = new UserModel(
      model:
        confirmation_token: param
    )
    userCall = @model.user.fetch(
      url: API_URL + '/users/confirm'
      data:
        confirmation_token: @model.user.attributes.model.confirmation_token
      type: 'POST'
      success: ->
        console.log('Success Confirmation User')
      error: (e) ->
        console.log('Service request failure: ' + e)
    )
    $.when( userCall ).done(
      (data) => (
        if (data.status == 'User confirmed successfully')
          document.cookie = 'Authorization=' + data.authorization
          Backbone.history.navigate('/', true)
        else
          Backbone.history.navigate('/login', true)
      )
    )
  onShowLogin: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    login = new Login(
      model: userModel
    )
    @showChildView('header', header)
    @showChildView('footer', footer)
    @showChildView('layout', login)
    Backbone.history.navigate('login/')
  onShowLogout: ->
    document.cookie = 'Authorization='
    @model.get('user').authorization = ''
    userModel = new UserModel(@model.get('user'))
    login = new Login(
      model: userModel
    )
    @showChildView('layout', login)
    Backbone.history.navigate('/login')
  onShowSignup: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    signup = new Signup(
      model: userModel
    )
    @showChildView('header', header)
    @showChildView('footer', footer)
    @showChildView('layout', signup)
    Backbone.history.navigate('login/')
  onShowHome: ->
    userModel = new UserModel(@model.get('user'))
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    homeModel = new HomeModel(@model.get('home'))
    home = new Home(
      model: homeModel
    )
    @showChildView('header', header)
    @showChildView('footer', footer)
    @showChildView('layout', home)
    Backbone.history.navigate('/')
  showBlog: (blogModel) ->
    userModel = new UserModel(@model.get('user'));
    header = new Header(
      model: userModel
    )
    footer = new Footer(
      model: userModel
    )
    blog = new Blog(
      model: blogModel
    )
    @showChildView('header', header)
    @showChildView('footer', footer)
    @showChildView('layout', blog)

    Backbone.history.navigate('blog/' + blog.model.id)
)

module.exports = LayoutView
