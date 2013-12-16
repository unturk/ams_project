#Sessions controller for logging in to website
class SessionsController < ApplicationController

  #Controller method that create new view of login
  def new
    if signed_in?
      redirect_to root_url
      flash[:notice] = "Zaten sisteme giriş yapmış durumdasınız."
    end
  end

  #Controller method for creating new session
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
          if verified?(user)
            complete_sign_in(user)
            return
          end
    end
    flash.now[:error] = 'Hesabınız yönetici tarafından onaylanmamış veya hatalı email/şifre kombinasyonu girdiniz!'
    render 'new'
  end

  #Controller method for destroying session
  def destroy
    sign_out
    redirect_to root_url
  end


  private
    #Helper method for completing signup
    def complete_sign_in(user)
      sign_in user
      redirect_back_or root_url
      flash[:success] = "Giriş başarılı!"
    end

end