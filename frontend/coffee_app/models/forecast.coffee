
Backbone = require('backbone')

module.exports = Backbone.Model.extend(
  initialize: (options) ->
    @apiForecast = options.apiForecast
  url: API_URL + '/forecast'
  fetch: (options) ->
    options = options || {}
    options.dataType = "json"
    return Backbone.Collection.prototype.fetch.call(@, options)
)

