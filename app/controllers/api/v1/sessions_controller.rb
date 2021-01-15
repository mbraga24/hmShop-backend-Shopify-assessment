class Api::V1::SessionsController < ApplicationController
  wrap_parameters :user, include: [:email, :password] 

  def login
    user = User.find_by(email: user_credentials_params[:email])

    if user && user.authenticate(user_credentials_params[:password])
      token = JWT.encode({ user_id: user.id }, 'a_big_secret', 'HS256')
      render json: { user: UserSerializer.new(user), token: token, success: "Welcome back, #{user.first_name}!" }, status: :accepted
    else
      render json: { error: user.error.full_messages, header: "Invalid email or password" }, status: :unauthorized
    end
  end

  def autologin
    auth_header = request.headers['Authorization']

    token = auth_header.split(" ")[1]

    decoded_token = JWT.decode(token, 'a_big_secret', true, { algorithm: 'HS256' })

    user_id = decoded_token[0]["user_id"]

    user = User.find_by(id: user_id)

    if user 
      render json: { user: UserSerializer.new(user) }, status: :ok
    else
      render json: { header: "You are not logged in." }
    end
  end

  private 

  def user_credentials_params
    params.require(:user).permit(:email, :password)
  end
end
