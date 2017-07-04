
Backbone = require('backbone')
Page = require('../models/page.coffee')

module.exports = Backbone.Collection.extend(
  model: Page
)
