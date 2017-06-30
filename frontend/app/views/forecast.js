
var Marionette = require('backbone.marionette');

var ForecastList = Marionette.LayoutView.extend({
  template: require('../templates/blog/forecast.html')
});

module.exports = ForecastList;