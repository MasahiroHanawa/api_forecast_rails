
var Backbone = require('backbone');
var Blog = require('../models/blog');

module.exports = Backbone.Collection.extend({
  model: Blog
});