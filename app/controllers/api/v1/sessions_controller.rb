class Api::V1::SessionsController < ApplicationController
  wrap_parameters :user, include: [:email, :password] 
  before_action :authenticate, only: [:autologin]

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
    # render json: { user: UserSerializer.new(@current_user) }, status: :ok

    # STEP 1
    auth_header = request.headers['Authorization']
    token = auth_header.split(" ")[1]

    # STEP 2
    decoded_token = JWT.decode(token, 'a_big_secret', true, { algorithm: 'HS256' })[0]

    # STEP 3
    user_id = decoded_token["user_id"]

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
