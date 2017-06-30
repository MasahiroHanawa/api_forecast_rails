
$(function(){

  var App = Backbone.Marionette.Application.extend({
    region: '#main-region',
    onStart: function(){
      console.log('It has started!!');
    }
  });

  var myApp = new App();

  myApp.start();

});
