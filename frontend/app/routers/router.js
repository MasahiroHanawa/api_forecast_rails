var Marionette = require('backbone.marionette');
var LayoutView = require('../views/layout');
var PageList = require('../models/page');
var Cookie = require('../util/cookie');

var Controller = Marionette.Object.extend({
  initialize: function() {
    this.options.regionManager = new Marionette.RegionManager({
      regions: {
        main: '#blog-hook'
      }
    });
    this.cookie = Cookie();
    var initialData = this.getOption('initialData');
    var layout = new LayoutView({
      model: new PageList(initialData)
    });

    this.getOption('regionManager').get('main').show(layout);

    /** We want easy access to our root view later */
    this.options.layout = layout;
  },

  home: function() {
    var layout = this.getOption('layout');
    this.cookie = Cookie();
    if (this.cookie['Authorization']) {
      layout.triggerMethod('show:home');
    } else {
      layout.triggerMethod('show:login');
    }
  },

  /** List all blog entrys with a summary */
  blogList: function() {
    var layout = this.getOption('layout');
    layout.triggerMethod('show:blog:list');
  },

  /** List a named entry with its comments underneath */
  blogEntry: function(entry) {
    var layout = this.getOption('layout');
    layout.triggerMethod('show:blog:entry', entry);
  },

  login: function() {
    var layout = this.getOption('layout');
    if (this.cookie['Authorization']) {
      layout.triggerMethod('show:home');
    } else {
      layout.triggerMethod('show:login');
    }
  },

  logout: function() {
    document.cookie = 'Authorization=';
    this.cookie['Authorization'] = '';
    var layout = this.getOption('layout');
    layout.triggerMethod('show:login');
  },

  signUp: function() {
    var layout = this.getOption('layout');
    layout.triggerMethod('show:signup');
  },

  signUpComplete: function() {
    var layout = this.getOption('layout');
    layout.triggerMethod('show:signup:complete');
  },

  signUpConfirm: function(param) {
    this.param = param;
    var layout = this.getOption('layout');
    layout.triggerMethod('show:signup:confirm', param);
  }
});

var Router = Marionette.AppRouter.extend({
  appRoutes: {
    '': 'home',
    'blog/': 'blogList',
    'blog/:entry': 'blogEntry',
    'login/': 'login',
    'logout/': 'logout',
    'signup/': 'signUp',
    'signup/complete': 'signUpComplete',
    'signup/confirm?(confirmation_token=:confirmation_token)': 'signUpConfirm'
  },

  initialize: function() {
    this.controller = new Controller({
      initialData: this.getOption('initialData')
    });
  }
});

module.exports = Router;