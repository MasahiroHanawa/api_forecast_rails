
Marionette = require('backbone.marionette')
Backbone = require('backbone')
CommentList = require('../models/comment.coffee')
CommentList = require('../collections/comment.coffee')
CommentListView = require('./commentList.coffee')

Blog = Marionette.LayoutView.extend(
  template: require('../templates/blog/blog.pug'),
  regions:
    comments: '.comment-hook'
  ,
  ui:
    back: '.back'
  ,
  triggers:
    'click @ui.back': 'show:blog:list'
  ,
  onShow: ->
    comments = new CommentList(this.model.get('comments'))
    commentView = new CommentListView(
      collection: comments
    )
    this.showChildView('comments', commentView)
)

module.exports = Blog