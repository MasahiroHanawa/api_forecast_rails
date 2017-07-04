
Backbone = require('backbone')
ForecastModel = require('../models/forecast.coffee')


module.exports = Backbone.Collection.extend(
  model: ForecastModel
  urlRoot: API_URL + '/forecast'
  url: (options) ->
    url = @urlRoot + '?token=' + options.token
    return url
  fetch: (options) ->
    options = options || {}
    options.dataType = "json"
    @.url(options)
    return Backbone.Collection.prototype.fetch.call(@, options)
)
