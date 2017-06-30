
var Marionette = require('backbone.marionette');
var ChartJs = require('chart.js');

var Diagram = Marionette.LayoutView.extend({
  template: require('../templates/blog/diagram.html'),
  onShow: function (){

    var weekDayList = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];

    var dt = null;
    var labels = [];
    var maxTemp = [];
    var minTemp = [];
    Object.keys(this.model.get('list')).forEach( function (key) {
      dt = new Date(this.model.get('list')[key].dt * 1000);
      labels.push(weekDayList[dt.getDay()]);
      maxTemp.push(this.model.get('list')[key].temp.max);
      minTemp.push(this.model.get('list')[key].temp.min);
    }.bind(this));
    var data = {
      labels: labels,
      datasets: [
        {
          label: 'Max temperature',
          fill: false,
          lineTension: 0.1,
          strokeColor: 'rgba(255, 0, 0, 0.5)',
          fillColor: 'rgba(255,255,255,0)',
          pointColor: 'rgba(255, 0, 0, 1)',
          pointStrokeColor: 'rgba(255, 0, 0, 1)',
          pointBorderWidth: 1,
          pointHoverRadius: 5,
          pointHoverBorderWidth: 2,
          pointRadius: 1,
          pointHitRadius: 10,
          data: maxTemp
        },
        {
          label: 'Min temperature',
          fill: false,
          lineTension: 0.1,
          strokeColor: 'rgba(0, 0, 255, 0.3)',
          fillColor: 'rgba(255,255,255,0)',
          pointColor: 'rgba(0, 0, 255, 0.8)',
          pointStrokeColor: 'rgba(0, 0, 255, 0.8)',
          pointBorderWidth: 1,
          pointHoverRadius: 5,
          pointHoverBorderWidth: 2,
          pointRadius: 1,
          pointHitRadius: 10,
          data: minTemp
        }
      ]
    };

    var ctx = $("#diagram").get(0).getContext("2d");
    ctx.canvas.width = 600;
    ctx.canvas.height = 250;
    ctx.canvas.class = 'center-block';
    var myLineChart = new ChartJs(ctx).Line(data);
  }

});
module.exports = Diagram;