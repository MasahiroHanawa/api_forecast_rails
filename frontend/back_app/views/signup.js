
var Marionette = require('backbone.marionette');
var UserModel = require('../models/user');

var SignUp = Marionette.LayoutView.extend({
  template: require('../templates/blog/signup.html'),
  ui: {
    signupConfirm: '.signupConfirm',
    email: '#email',
    password: '#password',
    passwordConfirm: '#password_confirm',
    emailError: '#email_error',
    passwordError: '#password_error',
    passwordConfirmError: '#password_confirm_error'
  },
  triggers: {
    'click @ui.signupConfirm': 'signup:confirm'
  },
  onSignupConfirm: function() {
    this.model = new UserModel({model: {
      email: this.$el.find(this.ui.email).val(),
      password: this.$el.find(this.ui.password).val(),
      passwordConfirm: this.$el.find(this.ui.passwordConfirm).val(),
      is_login: false
    }});
    var validate = this.model.isValid();
    if (validate === false) {
      this.showError();
    } else {
      var userCall = this.model.fetch({
        url: API_URL + '/users',
        data: {
          email: this.model.attributes.model.email,
          password: this.model.attributes.model.password,
          password_confirmation: this.model.attributes.model.passwordConfirm
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
          if (data.status === 'User created successfully') {
            Backbone.history.navigate('signup/complete', true);
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
    this.$el.find(this.ui.passwordConfirmError).empty(this.model.validationError.passwordConfirm);
    if (this.model.validationError.email) {
      this.$el.find(this.ui.emailError).append(this.model.validationError.email);
    }
    if (this.model.validationError.password) {
      this.$el.find(this.ui.passwordError).append(this.model.validationError.password);
    }
    if (this.model.validationError.passwordConfirm) {
      this.$el.find(this.ui.passwordConfirmError).append(this.model.validationError.passwordConfirm);
    }
  }
});


module.exports = SignUp;