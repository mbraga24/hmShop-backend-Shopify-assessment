class Api::V1::SessionsController < ApplicationController
  wrap_parameters :user, include: [:email, :password] 

  def login
    # byebug
    user = User.find_by(email: user_credentials_params[:email])

    if user && user.authenticate(user_credentials_params[:password])
      render json: { user: UserSerializer.new(user), success: "Welcome back #{user.first_name} #{user.last_name}!" }, status: :accepted
    else
      render json: { error: user.error.full_messages, header: "Invalid email or password" }, status: :unauthorized
    end
  end

  def autologin
    byebug
  end

  private 

  def user_credentials_params
    params.require(:user).permit(:email, :password)
  end
end
