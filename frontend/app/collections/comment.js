
var Backbone = require('backbone');
var Comment = require('../models/comment');


module.exports = Backbone.Collection.extend({
  model: Comment
});
