var Marionette = require('backbone.marionette');
var Backbone = require('backbone');
var Header = require('./header');
var Footer = require('./footer');
var List = require('./list');
var Blog = require('./blog');
var Home = require('./home');
var HomeModel = require('../models/home');
var Login = require('./login');
var Signup = require('./signup');
var SignupComplete = require('./signupComplete');
var UserModel = require('../models/user');
var BlogList = require('../collections/blog');


var LayoutView = Marionette.LayoutView.extend({
  template: require('../templates/blog/layout.html'),

  regions: {
    header: '.header-hook',
    footer: '.footer-hook',
    layout: '.layout-hook'
  },

  onShowBlogList: function() {
    var userModel = new UserModel(this.model.get('user'));
    var header = new Header({model: userModel});
    var footer = new Footer({model: userModel});
    var blogList = new BlogList(this.model.get('pages').blog.posts);
    var list = new List({collection: blogList});
    this.showChildView('header', header);
    this.showChildView('footer', footer);
    this.showChildView('layout', list);
    Backbone.history.navigate('blog/');
  },

  onShowBlogEntry: function(entry) {
    var model = this.collection.get(entry);
    this.showBlog(model);
  },

  onChildviewSelectEntry: function(child, model) {
    this.showBlog(model);
  },

  onChildviewShowBlogList: function() {
    this.triggerMethod('show:blog:list');
  },

  onShowSignup: function() {
    var header = new Header();
    var footer = new Footer();
    var signup = new Signup();
    this.showChildView('footer', header);
    this.showChildView('header', footer);
    this.showChildView('layout', signup);
    Backbone.history.navigate('signup/');
  },

  onShowSignupComplete: function() {
    var header = new Header();
    var footer = new Footer();
    var signupComplete = new SignupComplete();
    this.showChildView('footer', header);
    this.showChildView('header', footer);
    this.showChildView('layout', signupComplete);
    Backbone.history.navigate('signup/complete');
  },

  onShowSignupConfirm: function(param) {
    this.model.user = new UserModel({
      model: {
        confirmation_token: param
      }
    });
    var userCall = this.model.user.fetch({
      url: API_URL + '/users/confirm',
      data: {
        confirmation_token: this.model.user.attributes.model.confirmation_token
      },
      type: 'POST',
      success: function() {
        console.log('Success Confirmation User');
      },
      error: function (e) {
        console.log('Service request failure: ' + e);
      }
    });
    $.when( userCall ).done(
      function (data) {
        if (data.status === 'User confirmed successfully') {
          document.cookie = 'Authorization=' + data.authorization;
          Backbone.history.navigate('/', true);
        } else {
          Backbone.history.navigate('/login', true);
        }
      }.bind(this)
    );
  },

  onShowLogin: function() {
    var userModel = new UserModel(this.model.get('user'));
    var header = new Header({model: userModel});
    var footer = new Footer({model: userModel});
    var login = new Login({model: userModel});
    this.showChildView('header', header);
    this.showChildView('footer', footer);
    this.showChildView('layout', login);
    Backbone.history.navigate('login/');
  },

  onShowLogout: function() {
    document.cookie = 'Authorization=';
    this.model.get('user').authorization = '';
    var userModel = new UserModel(this.model.get('user'));
    var login = new Login({model: userModel});
    this.showChildView('layout', login);
    Backbone.history.navigate('login/');
  },
  onShowHome: function() {
    var userModel = new UserModel(this.model.get('user'));
    var header = new Header({model: userModel});
    var footer = new Footer({model: userModel});
    var homeModel = new HomeModel(this.model.get('home'));
    var home = new Home({model: homeModel});
    this.showChildView('header', header);
    this.showChildView('footer', footer);
    this.showChildView('layout', home);
    Backbone.history.navigate('/');
  },
  showBlog: function(blogModel) {
    var userModel = new UserModel(this.model.get('user'));
    var header = new Header({model: userModel});
    var footer = new Footer({model: userModel});
    var blog = new Blog({model: blogModel});
    this.showChildView('header', header);
    this.showChildView('footer', footer);
    this.showChildView('layout', blog);

    Backbone.history.navigate('blog/' + blog.model.id);
  }
});

module.exports = LayoutView;
