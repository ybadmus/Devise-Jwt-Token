class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    super
  end

  def create
    user = User.create(user_params)
    user.save
    respond_with user
  end

  private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed resource
    end

    def register_success
      render json: { message: 'Signed up sucessfully.' }
    end

    def register_failed resource
      render json: { message: resource.errors }
    end

    def user_params
      params.require(:registration).permit(:email, :password)
    end
end