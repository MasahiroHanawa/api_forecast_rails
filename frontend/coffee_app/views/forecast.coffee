
Marionette = require('backbone.marionette')

ForecastList = Marionette.LayoutView.extend(
  template: require('../templates/blog/forecast.pug')
)

module.exports = ForecastList