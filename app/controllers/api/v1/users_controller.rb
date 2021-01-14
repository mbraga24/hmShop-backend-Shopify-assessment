class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:first_name, :last_name, :email, :password]

  def index
    users = User.all
    render json: users
  end

  def create 
    user = User.create(user_params)

    if user.valid?
      render json: { user: UserSerializer.new(user), success: "Welcome to HmShop #{user.first_name} #{user.last_name}!" }, status: :created
    else
      render json: { header: "Check the error(s) bellow:" , error: user.errors.full_messages,  }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
