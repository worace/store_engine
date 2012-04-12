class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all


  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  private

  def cart
    @cart ||= find_or_create_cart
  end

  def find_or_create_cart
    if current_user
      session[:cart_id] = current_user.cart.id
      Cart.find_by_id(session[:cart_id])
    elsif session[:cart_id]
      Cart.find_by_id(session[:cart_id])
    else
      Cart.create.tap{ |c| session[:cart_id] = c.id }
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user, :cart

  # def authenticate
  #   logged_in? ? true : access_denied
  # end

  # def access_denied
  #   redirect_to login_path, :notice => "Please log in to continue" and return false
  # end

  # def authorize
  #   if current_user.admin = true
  #     true
  #   else
  #     redirect_to root
  #   end
  # end

end