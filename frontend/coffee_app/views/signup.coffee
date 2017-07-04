
Marionette = require('backbone.marionette')
UserModel = require('../models/user.coffee')
Backbone = require('backbone')

SignUp = Marionette.LayoutView.extend(
  template: require('../templates/blog/signup.pug')
  ui:
    signupConfirm: '.signupConfirm'
    email: '#email'
    password: '#password'
    passwordConfirm: '#password_confirm'
    emailError: '#email_error'
    passwordError: '#password_error'
    passwordConfirmError: '#password_confirm_error'
  triggers: 
    'click @ui.signupConfirm': 'signup:confirm'
  onSignupConfirm: ->
    @model = new UserModel(
      model:
        email: @$el.find(@ui.email).val()
        password: @$el.find(@ui.password).val()
        passwordConfirm: @$el.find(@ui.passwordConfirm).val()
        is_login: false
    )
    validate = @model.isValid()
    if (validate == false)
      @showError()
    else
      userCall = @model.fetch(
        url: API_URL + '/users'
        data: 
          email: @model.attributes.model.email
          password: @model.attributes.model.password
          password_confirmation: @model.attributes.model.passwordConfirm
        type: 'POST'
        success: ->
          console.log('Success Register User')
        error: (e) ->
          console.log('Service request failure: ' + e)
      )
      $.when( userCall ).done(
        (data) => (
          if (data.status == 'User created successfully')
            Backbone.history.navigate('signup/complete', true)
          else
            console.log(data)
        )
      )
  showError: ->
    @$el.find(@ui.emailError).empty()
    @$el.find(@ui.passwordError).empty(@model.validationError.password)
    @$el.find(@ui.passwordConfirmError).empty(@model.validationError.passwordConfirm)
    if (this.model.validationError.email)
      @$el.find(@ui.emailError).append(@model.validationError.email)
    if (@model.validationError.password)
      @$el.find(@ui.passwordError).append(@model.validationError.password)
    if (@model.validationError.passwordConfirm)
      this.$el.find(@ui.passwordConfirmError).append(@model.validationError.passwordConfirm)
)

module.exports = SignUp