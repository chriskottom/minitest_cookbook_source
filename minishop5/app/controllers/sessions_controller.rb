class SessionsController < ApplicationController
  skip_before_action   :authorize


  def new
  end

  def create
    if user = User.authenticate(session_params[:name], session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path, alert: "Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path, notice: "Logged out"
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.permit(:name, :password)
  end
end
