Marionette = require('backbone.marionette')

Comment = Marionette.LayoutView.extend(
  template: require('../templates/blog/comment.pug'),
  tagName: 'li'
)
CommentList = Marionette.CollectionView.extend(
  childView: Comment,
  tagName: 'ul'
)

module.exports = CommentList