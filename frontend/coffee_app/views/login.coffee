
Marionette = require('backbone.marionette')
UserModel = require('../models/user.coffee')

Login = Marionette.LayoutView.extend(
  template: require('../templates/blog/login.pug')
  ui:
    loginConfirm: '.loginConfirm'
    email: '#email'
    password: '#password'
    emailError: '#email_error'
    passwordError: '#password_error'
  triggers:
    'click @ui.loginConfirm': 'login:confirm'
  onLoginConfirm: ->
    @model = new UserModel(
      model:
        email: @$el.find(@ui.email).val()
        password: @$el.find(@ui.password).val()
        is_login: true
    )
    validate = this.model.isValid()
    if (validate == false)
      @showError()
    else
      userCall = @model.fetch(
        url: API_URL + '/users/login'
        data:
          email: @model.attributes.model.email
          password: @model.attributes.model.password
        type: 'POST'
        success: ->
          console.log('Success Register User')
        error: (e) ->
          console.log('Service request failure: ' + e)
      )
      $.when( userCall ).done(
        (data) => (
          if (data.authorization)
            document.cookie = 'Authorization=' + data.authorization
            this.options.model.attributes.authorization = data.authorization
            Backbone.history.navigate('/', true)
          else
            console.log(data)
        )
      )
  showError: ->
    @$el.find(@ui.emailError).empty()
    @$el.find(@ui.passwordError).empty(@model.validationError.password)
    if (@model.validationError.email)
      @$el.find(@ui.emailError).append(@model.validationError.email)
    if (@model.validationError.password)
      @$el.find(@ui.passwordError).append(@model.validationError.password)
)

module.exports = Login