
Backbone = require('backbone')
module.exports = Backbone.Model.extend(
  fetch: (options) ->
    options = options || {}
    options.dataType = "json"
    return Backbone.Collection.prototype.fetch.call(@, options)
  validate: (attrs) ->
    errors = []
    error_len = 0
    if (!attrs.model.email)
      errors['email'] = "please fill out email"
    else if (!attrs.model.email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/))
      errors['email'] = "don't match email"

    if (!attrs.model.password)
      errors['password'] = "please fill out password";
    else if (attrs.model.password.length < 7 && !attrs.model.is_login)
      errors['password'] = "please fill out password more than 8 character"
    else if (!attrs.model.passwordConfirm && !attrs.model.is_login)
      errors['passwordConfirm'] = "please fill out password confirm"
    else if (attrs.model.password != attrs.model.passwordConfirm && !attrs.model.is_login)
      errors['password'] = "don't match password and password confirm"

    for key in errors
      error_len++

    if(error_len > 0)
      return errors
)
