
Backbone = require('backbone')

module.exports = Backbone.Model.extend(
  defaults:
    city:
      coord:
        lat: null
        lon: null
      country: null
      id: null
      name: null
      population: null
    cnt: null
    cod: null
    list:[]
    message: null
  url: FORECAST_API_URL + '/data/2.5/forecast/daily'
  fetch: (options) ->
    options = options || {}
    options.dataType = "json"
    return Backbone.Collection.prototype.fetch.call(@, options)
)