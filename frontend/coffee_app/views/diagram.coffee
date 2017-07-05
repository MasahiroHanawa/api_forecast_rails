
Marionette = require('backbone.marionette')
ChartJs = require('chart.js')

Diagram = Marionette.LayoutView.extend(
  template: require('../templates/blog/diagram.pug'),
  onShow: -> 
    weekDayList = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ]

    dt = null
    labels = []
    maxTemp = []
    minTemp = []

    Object.keys(@model.get('list')).forEach ((key) ->
      dt = new Date(@model.get('list')[key].dt * 1000)
      labels.push weekDayList[dt.getDay()]
      maxTemp.push @model.get('list')[key].temp.max
      minTemp.push @model.get('list')[key].temp.min
      return
    ).bind(@)
    data =
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
        }
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

    ctx = $("#diagram").get(0).getContext("2d")
    ctx.canvas.width = 600
    ctx.canvas.height = 300
    ctx.canvas.class = 'center-block'
    myLineChart = new ChartJs(ctx).Line(data)
)

module.exports = Diagram