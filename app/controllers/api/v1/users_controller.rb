class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:first_name, :last_name, :email, :password]

  def index
    users = User.all
    render json: users
  end

  def create 
    # byebug
    user = User.create(user_params)

    if user.valid?
      render json: { user: UserSerializer.new(user) }, status: :created
    else
      render json: { message: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
