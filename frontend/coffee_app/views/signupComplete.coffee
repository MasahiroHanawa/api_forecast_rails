
Marionette = require('backbone.marionette')

SignupComplete = Marionette.LayoutView.extend(
  template: require('../templates/blog/signupComplete.pug')
)

module.exports = SignupComplete