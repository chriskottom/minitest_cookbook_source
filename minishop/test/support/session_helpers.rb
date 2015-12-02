module SessionHelpers
  def login_as(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
