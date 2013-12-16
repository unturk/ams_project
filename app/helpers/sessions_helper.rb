#Includes all methods about login
module SessionsHelper

#Method for checking given user verified or not
  def verified?(user)
    return user.verified?
  end

#Method for checking access permission to pages
  def correct_user
    @user = User.find(params[:id])
    if (!current_user?(@user))
      redirect_to(root_url)
      flash[:notice] = "Sadece kendi hesabiniz icin ulasabilirsiniz!"
    end
  end

#Method for checking current user is admin or not
  def admin_user
    if(!current_user.admin?)
      redirect_to root_url
      flash[:notice] = "Sayfaya erişim yetkiniz yok!"
    end
  end

#Method for logging in given user
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

#Method for logging out
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

#Method for assigning given user to current user variable
  def current_user=(user)
    @current_user = user
  end

#Method for getting current user
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

#Method for finding current users apartment number
  def kiraci_user
    if Renter.all.blank?
      flash[:notice] = "Kiracı kayıtlı değil.!"
    else
      @user = User.find(current_user)
      @renter = Renter.find_by_email(@user.email )
      return @renter.ap_num
    end
  end

#Methof for checking given user is current user or not
  def current_user?(user)
    user == current_user
  end

#Method for checking a user is signed in or not
  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Sayfaya erişmek için giriş yapmanız gerekmektedir."
      end
    end

#Method for checking current user is nil or not
  def signed_in?
    current_user#!current_user.nil?
  end

#Method for redirecting back to another page with default parameter if given
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

#Method for storing location in web page for returning it later
  def store_location
    session[:return_to] = request.url if request.get?
  end
end