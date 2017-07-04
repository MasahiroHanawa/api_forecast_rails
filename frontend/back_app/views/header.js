var Cookie = require('../util/cookie');
var Marionette = require('backbone.marionette');
var cookie = Cookie();

var Header = Marionette.LayoutView.extend({
  template: require('../templates/blog/header.html'),
  initialize: function (){
    this.model.set({authorization: cookie['Authorization']})
  },
  ui: {
    home: '#home',
    blog: '#blog',
    logout: '#logout',
    login: '#login'
  },
  events: {
    'click @ui.home': 'show:home',
    'click @ui.blog': 'show:blog:list',
    'click @ui.logout': 'show:logout',
    'click @ui.login': 'show:login'
  }
});


module.exports = Header;