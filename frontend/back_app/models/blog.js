
var Backbone = require('backbone');
var Marionette = require('backbone.marionette');

module.exports = Backbone.Model.extend({
  defaults: function() {
    return {
      comments: []
    }
  }
});