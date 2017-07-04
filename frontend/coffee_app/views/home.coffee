
Marionette = require('backbone.marionette')
ApiForecastModel = require('../models/apiForecast.coffee')
ForecastModel = require('../models/forecast.coffee')
ForecastsView = require('./forecast.coffee')
DiagramView = require('./diagram.coffee')
Cookie = require('../util/cookie.coffee')


Home = Marionette.LayoutView.extend(
  template: require('../templates/blog/home.pug'),
  regions:
    diagram: '.diagram-hook',
    forecasts: '.forecasts-hook'
  ui:
    search: '#search'
  events:
    'click @ui.search': 'searchForecast'
  initialize : ->
    @model.apiForecast = new ApiForecastModel(
      model: @model.get('apiForecast')
    )
    @model.forecast = new ForecastModel(
      model: @model.get('forecast')
    )
    cookie = Cookie()
    forecastCall = this.model.forecast.fetch(
      data:
        token: cookie['Authorization']
      headers:
        Authorization: cookie['Authorization']
      success: ->
        console.log('Success Forecast')
      error: (e) ->
        console.log('Service request failure: ' + e)
    )

    $.when( forecastCall )
    .done( => (
        @getApiForecast()
        return
      )
    )
    return

  getApiForecast: ->
    apiForecastCall = this.model.apiForecast.fetch(
      data:
        id: this.model.forecast.get('city_id'),
        units: 'metric',
        cnt: 6,
        appid: APP_ID
      success: ->
        console.log('Success Api Forecast')
      error: (e) ->
        console.log('Service request failure: ' + e)
    )
    $.when( apiForecastCall )
    .done( => (
      @onRender()
      return
      )
    )

  searchForecast : ->
    @model.apiForecast = new ApiForecastModel(
      model: @model.get('apiForecast')
    )
    @model.forecast = new ForecastModel(
      model: @model.get('forecast')
    )
    cookie = Cookie()
    forecastCall = this.model.forecast.fetch(
      data:
        token: cookie['Authorization']
      headers:
        Authorization: cookie['Authorization']
      success: ->
        console.log('Success Forecast')
      error: (e) ->
        console.log('Service request failure: ' + e)
    )

    $.when( forecastCall ).done(
      => (
        @getApiForecast()
      )
    )
    @listenTo(@model.forecast, 'sync' , @onRender())
  onRender: ->
    if (@model.apiForecast.get('cnt') != null)
      diagramView = new DiagramView(
        model: @model.apiForecast
      )
      forecastView = new ForecastsView(
        model: @model.apiForecast
      )
      @showChildView('diagram', diagramView)
      @showChildView('forecasts', forecastView)
)

module.exports = Home;