class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      jwt = Auth.issue({user: user.id})
      response = {
        jwt: jwt,
        id: user.id,
        email: user.email,
        name: user.name
      }
      render json: response, status: 201
    else
      render json: {error: user.errors.full_messages.join(',')}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
