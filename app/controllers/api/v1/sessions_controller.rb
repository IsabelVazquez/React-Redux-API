class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      response = {
        id: user.id,
        email: user.email,
        name: user.name
      }
      render json: response, status: 201
    else
      render json: {errors: "Invalid username or password"}, status: 401
    end
  end

  private
  def login_params
    params.require(:login).permit(:email, :password)
  end

end
