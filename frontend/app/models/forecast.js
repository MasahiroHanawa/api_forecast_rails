
var Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  initialize: function(options) {
    this.apiForecast = options.apiForecast;
  },
  url: API_URL + '/forecast',
  fetch: function (options) {
    options = options || {};
    options.dataType = "json";
    return Backbone.Collection.prototype.fetch.call(this, options);
  }
});

