
Backbone = require('backbone')
Comment = require('../models/comment.coffee')

module.exports = Backbone.Collection.extend(
  model: Comment
)
