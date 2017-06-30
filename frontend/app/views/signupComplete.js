
var Marionette = require('backbone.marionette');

var SignupComplete = Marionette.LayoutView.extend({
  template: require('../templates/blog/signupComplete.html'),
});

module.exports = SignupComplete;