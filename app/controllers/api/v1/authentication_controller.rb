class API::V1::AuthenticationController < ApplicationController

  def login
    user = User.find_by(email: params[:authentication][:email])
    if !user.nil? && (user.valid_password? params[:authentication][:password_digest])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"] }
    end
  end
  
end