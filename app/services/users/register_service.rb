module Users

  module RegisterService
    module_function
    def register_user(user = {})

      if user.save
        UserMailer::confirmation_email(user).deliver
        result = { json: {status: 'User created successfully'}, status: :created }
      else
        result = { json: { errors: user.errors.full_messages }, status: :bad_request }
      end

      return result
    end

    def confirm_user(confirmation_token)

      user = User.find_by(confirmation_token: confirmation_token)
      if user.present? && user.confirmation_token_valid?
        user.mark_as_confirmed!
        auth_token = JsonWebToken.encode({user_id: user.id})
        @current_user = user
        result = { json: {
            status: 'User confirmed successfully',
            authorization: auth_token
        }, status: :ok }
      else
        result = { json: {status: 'Invalid token'}, status: :not_found }
      end

      return result
    end
  end
end
