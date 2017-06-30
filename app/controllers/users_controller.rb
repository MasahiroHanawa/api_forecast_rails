class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    user = Users::RegisterService.register_user(user)

    render_json(user)
  end

  def confirm
    confirmation_token = params[:confirmation_token].to_s

    user = Users::RegisterService.confirm_user(confirmation_token)

    log = Logger.new(STDOUT)
    log.debug(@current_user)

    render_json(user)
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.authenticate(params[:password])
      if user.confirmed_at?
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: {authorization: auth_token}, status: :ok
      else
        render json: {error: 'Email not verified' }, status: :unauthorized
      end
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
