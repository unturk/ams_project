class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update , :show]
  before_action :admin_user,     only: [:index, :destroy ]
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 30)#.order('name ASC')
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil güncellendi."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def create
    #@user = User.new(params[:user]) Not safe and deprecated!
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Kayıt başarılı, AYS uygulamasına hoşgeldiniz!" 
      #redirect_to @user
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Kullanıcı başarıyla silindi."
    redirect_to users_url
  end

  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
