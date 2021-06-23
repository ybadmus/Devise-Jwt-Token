class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    login_success && return if resource.persisted?

    login_failed
  end

  def login_success
    render json: { message: 'You are logged in.' }, status: :ok
  end

  def login_failed
    render json: { message: 'Invalid username or password' }
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Try again."}, status: :unauthorized
  end
  
end