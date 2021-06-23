class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if !user.nil? && (user.valid_password? params[:session][:password_digest])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"] }
    end
  end
  
end