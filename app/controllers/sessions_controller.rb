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
     sign_in user
     #redirect_back_or user
     redirect_back_or root_url
     flash[:success] = "Giriş başarılı!" 
    else
      flash.now[:error] = 'Hatalı email/şifre kombinasyonu, tekrar deneyiniz!'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
  
end
