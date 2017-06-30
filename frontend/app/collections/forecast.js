
var Backbone = require('backbone');
var ForecastModel = require('../models/forecast');


module.exports = Backbone.Collection.extend({
  model: ForecastModel,
  urlRoot : API_URL + '/forecast',
  url: function (options) {
    var url = this.urlRoot + '?token=' + options.token;
    return url;
  },
  fetch: function (options) {
    options = options || {};
    options.dataType = "json";
    this.url(options);
    return Backbone.Collection.prototype.fetch.call(this, options);
  }
});
