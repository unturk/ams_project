# Controller that users can see their profiles and admin can confirm,delete users
class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]

#Controller method for creating new view of the user
  def new
    @user = User.new
  end

#Contoller method for listing users
  def index
    @users = User.paginate(page: params[:page], per_page: 30)#.order('name ASC')
  end

#Controller method for showing the user(s)
  def show
    @user = User.find(params[:id])
  end

#Controller method for editing the user
  def edit
  end

#Controller method for updating the user
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil güncellendi."
      redirect_to @user
    else
      render 'edit'
    end
  end

 #Controller method for creating new user
  def create
    @user = User.new(user_params)
    if @user.save
      #sign_in @user
      flash[:success] = "Kayıt başarılı, AYS uygulamasına hoşgeldiniz!"
      redirect_to signin_path
    else
      render 'new'
    end
  end

 #Controller method for deleting the user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Kullanıcı başarıyla silindi."
    redirect_to users_url
  end

 #Contoller method for verifying the user by admin
  def verify
    @user = User.find(params[:id])
    @user.update_attribute(:verified, true)
    redirect_to @user
    flash[:success] = "Kullanıcı başarıyla onaylandı!"
  end

 #Controller method to not accept user verification
  def unverify
    @user = User.find(params[:id])
    @user.update_attribute(:verified, false)
    redirect_to @user
    flash[:success] = "Kullanıcı onayı başarıyla silindi!"
  end

  private
  #Special method for getting specific parameters
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end