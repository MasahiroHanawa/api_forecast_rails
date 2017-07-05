Marionette = require('backbone.marionette')
Router = require('./routers/router.coffee')
Style = require('./css/style.css')
#Bootstrap = require('bootstrap')
require('bootstrap/dist/css/bootstrap.css')

initialData =
  pages:
    home:
      forecast: {}
      apiForecast:
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
    blog:
      posts: [
          author: 'Scott'
          title: 'Why Marionette is amazing'
          content: '...'
          id: 42
          comments: [
              author: 'Steve'
              content: 'Good evening'
              id: 56
            ,
              author: 'Masahiro'
              content: 'Oh yes'
              id: 57
          ]
          author: 'Andrew'
          title: 'How to use Routers'
          content: '...'
          id: 17
          comments: [
              author: 'Arfe'
              content: 'How are you?'
              id: 58
            ,
              author: 'Joje'
              content: 'Oh no!'
              id: 60
          ]
      ]
  user: {}

App = new Marionette.Application(
  onStart: (options) ->
    router = new Router(options)

    Backbone.history.start(
      pushState: true
    )
#    Backbone.history.start()
)

App.start(initialData: initialData)
