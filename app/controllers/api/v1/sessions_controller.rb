class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:login]
  wrap_parameters :user, include: [:email, :password] 

  def login
    user = User.find_by(email: user_credentials_params[:email])

    if user && user.authenticate(user_credentials_params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: UserSerializer.new(user), token: token, success: "Welcome back, #{user.first_name}!" }, status: :accepted
    else
      render json: { error: user.error.full_messages, header: "Invalid email or password" }, status: :unauthorized
    end
  end

  def autologin
    render json: { user: UserSerializer.new(@current_user) }, status: :ok
  end

  private 

  def user_credentials_params
    params.require(:user).permit(:email, :password)
  end
end
