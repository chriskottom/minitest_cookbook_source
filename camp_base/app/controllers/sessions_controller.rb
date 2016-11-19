class SessionsController < ApplicationController
  def create
    user = User.find_by(login: params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Welcome back, #{user.login}"
    else
      flash.now.alert = "Invalid email or password"
      render plain: "foo"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
