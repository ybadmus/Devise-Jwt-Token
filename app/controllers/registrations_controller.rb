class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    user = User.create(user_params)
    if user.save
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    
    def user_params
      params.require(:registration).permit(:email, :password)
    end
end