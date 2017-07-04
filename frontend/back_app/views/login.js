
var Marionette = require('backbone.marionette');
var UserModel = require('../models/user');

var Login = Marionette.LayoutView.extend({
  template: require('../templates/blog/login.html'),
  ui: {
    loginConfirm: '.loginConfirm',
    email: '#email',
    password: '#password',
    emailError: '#email_error',
    passwordError: '#password_error'
  },

  triggers: {
    'click @ui.loginConfirm': 'login:confirm'
  },
  onLoginConfirm: function() {
    this.model = new UserModel({model: {
      email: this.$el.find(this.ui.email).val(),
      password: this.$el.find(this.ui.password).val(),
      is_login: true
    }});
    var validate = this.model.isValid();
    if (validate === false) {
      this.showError();
    } else {
      var userCall = this.model.fetch({
        url: API_URL + '/users/login',
        data: {
          email: this.model.attributes.model.email,
          password: this.model.attributes.model.password
        },
        type: 'POST',
        success: function() {
          console.log('Success Register User');
        },
        error: function (e) {
          console.log('Service request failure: ' + e);
        }
      });
      $.when( userCall ).done(
        function (data) {
          if (data.authorization) {
            document.cookie = 'Authorization=' + data.authorization;
            this.options.model.attributes.authorization = data.authorization;
            Backbone.history.navigate('/', true);
          } else {
            console.log(data);
          }
        }.bind(this)
      );
    }
  },
  showError: function () {
    this.$el.find(this.ui.emailError).empty();
    this.$el.find(this.ui.passwordError).empty(this.model.validationError.password);
    if (this.model.validationError.email) {
      this.$el.find(this.ui.emailError).append(this.model.validationError.email);
    }
    if (this.model.validationError.password) {
      this.$el.find(this.ui.passwordError).append(this.model.validationError.password);
    }
  }


});


module.exports = Login;