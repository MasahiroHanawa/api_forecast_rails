
Backbone = require('backbone')
Blog = require('../models/blog.coffee')

module.exports = Backbone.Collection.extend(
  model: Blog
)