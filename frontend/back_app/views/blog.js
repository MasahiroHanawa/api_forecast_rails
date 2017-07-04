
var Marionette = require('backbone.marionette');
var Backbone = require('backbone');

// var CommentList = require('../models/comment');
var CommentList = require('../collections/comment');
var CommentListView = require('./commentList');

var Blog = Marionette.LayoutView.extend({
  template: require('../templates/blog/blog.html'),

  regions: {
    comments: '.comment-hook'
  },

  ui: {
    back: '.back'
  },

  triggers: {
    'click @ui.back': 'show:blog:list'
  },

  onShow: function() {
    var comments = new CommentList(this.model.get('comments'));
    var commentView = new CommentListView({collection: comments});
    this.showChildView('comments', commentView);
  }
});

module.exports = Blog;