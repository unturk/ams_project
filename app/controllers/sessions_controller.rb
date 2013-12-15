#Sessions controller for logging in to website
class SessionsController < ApplicationController
  
  def new
    if signed_in?
      redirect_to root_url
      flash[:notice] = "Zaten sisteme giriş yapmış durumdasınız."
    end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
          if verified?(user)
            sign_in user
            redirect_back_or root_url
            flash[:success] = "Giriş başarılı!"
            return
          end
    end
    flash.now[:error] = 'Hesabınız yönetici tarafından onaylanmamış veya hatalı email/şifre kombinasyonu girdiniz!'
    render 'new'
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
  
end
