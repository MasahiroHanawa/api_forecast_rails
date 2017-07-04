
Backbone = require('backbone')
ApiForecastModel = require('../models/apiForecast.coffee')


module.exports = Backbone.Collection.extend(
  model: ApiForecastModel
  url: FORECAST_API_URL + '/data/2.5/forecast/daily'
    fetch: (options) ->
      options = options || {}
      options.dataType = "json"
      return Backbone.Collection.prototype.fetch.call(this, options)
)
