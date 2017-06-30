
var Marionette = require('backbone.marionette');

var Comment = Marionette.LayoutView.extend({
  template: require('../templates/blog/comment.html'),
  tagName: 'li',
});

var CommentList = Marionette.CollectionView.extend({
  childView: Comment,
  tagName: 'ul'
});

module.exports = CommentList;