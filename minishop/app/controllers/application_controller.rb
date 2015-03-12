class ApplicationController < ActionController::Base
  before_action        :authorize
  protect_from_forgery with: :exception

  helper_method        :current_user, :logged_in?


  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def authorize
    redirect_to(login_path, alert: "You need to login first.") unless logged_in?
  end
end
