
var Marionette = require('backbone.marionette');
var ApiForecastModel = require('../models/apiForecast');
var ForecastModel = require('../models/forecast');
var ForecastsView = require('./forecast');
var DiagramView = require('./diagram');
var Cookie = require('../util/cookie');


var Home = Marionette.LayoutView.extend({
  template: require('../templates/blog/home.html'),
  regions: {
    diagram: '.diagram-hook',
    forecasts: '.forecasts-hook'
  },
  ui: {
    search: '#search'
  },
  events: {
    'click @ui.search': 'searchForecast'
  },

  initialize : function() {
    this.model.apiForecast = new ApiForecastModel({model: this.model.get('apiForecast')});
    this.model.forecast = new ForecastModel({model: this.model.get('forecast')});
    var cookie = Cookie();
    var forecastCall = this.model.forecast.fetch({
      data: {
        token: cookie['Authorization']
      },
      headers: {
        Authorization: cookie['Authorization']
      },
      success: function() {
        console.log('Success Forecast');
      },
      error: function (e) {
        console.log('Service request failure: ' + e);
      }
    });

    $.when( forecastCall ).done(
      function () {
        this.getApiForecast();
      }.bind(this)
    );
  },

  getApiForecast: function() {
    var apiForecastCall = this.model.apiForecast.fetch({
      data: {
        id: this.model.forecast.get('city_id'),
        units: 'metric',
        cnt: 6,
        appid: APP_ID
      },
      success: function() {
        console.log('Success Api Forecast');
      },
      error: function (e) {
        console.log('Service request failure: ' + e);
      }
    });
    $.when( apiForecastCall ).done( function () {
      this.onRender()
    }.bind(this));
  },

  searchForecast : function() {
    this.model.apiForecast = new ApiForecastModel({model: this.model.get('apiForecast')});
    this.model.forecast = new ForecastModel({model: this.model.get('forecast')});
    var cookie = Cookie();
    var forecastCall = this.model.forecast.fetch({
      data: {
        token: cookie['Authorization']
      },
      headers: {
        Authorization: cookie['Authorization']
      },
      success: function() {
        console.log('Success Forecast');
      },
      error: function (e) {
        console.log('Service request failure: ' + e);
      }
    });

    $.when( forecastCall ).done(
      function () {
        this.getApiForecast();
      }.bind(this)
    );
    this.listenTo(this.model.forecast, 'sync' , this.onRender());
  },
  onRender: function() {
    if (this.model.apiForecast.get('cnt') !== null) {
      var diagramView = new DiagramView({model: this.model.apiForecast});
      var forecastView = new ForecastsView({model: this.model.apiForecast});
      this.showChildView('diagram', diagramView);
      this.showChildView('forecasts', forecastView);
    }
  }
});

module.exports = Home;