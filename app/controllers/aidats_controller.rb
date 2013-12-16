#Controller that is add,edit,delete subscriptions which belong to renters
class AidatsController < ApplicationController

  before_action :signed_in_user, only: [:show, :index]
  #before_action :correct_user, only: [:show]
  before_action :admin_user, only: [:index, :create, :update, :edit, :new, :destroy]

 #Controller method for listing all paid subscriptions
  def index
    if !(Renter.any?)#saved from duplicat - Renter.all.blank?
      flash[:error] = "Kayıtlı Kiracı Yok. Lütfen Ekleyin."
      redirect_to renters_path
    else
      @renters = Renter.all.order('ap_num ASC')
    end
  end

#Controller method for showing specific renters subscriptions
  def show
    @daire_no = params[:id]
    if !(Aidat.find_by_daire(@daire_no))#saved from nil check - .nil?
      no_daire_error(@daire_no)
    else
      #@kiraciaidat = Aidat.find_by_daire(daire_no)
      @gecmis = Aidat.order('year ASC').find_all_by_daire(@daire_no)
      @kiraci = Renter.find_by_ap_num( @daire_no )
    end
  end

#Controller method for deleting paid subscriptions
  def destroy
    @aidatsil = Aidat.find(params[:id])
    daire_num = @aidatsil.daire
    
    if @aidatsil.destroy
      flash[:success] = "Aidat Silindi"
    else
      flash[:error] = "Aidat silinemedi, tekrar deneyiniz."
    end
    redirect_to aidat_path( daire_num )
  end

#Controller method for creating view of new subscriptions
  def new
    @aidat = Aidat.new
  end

#Controller method for editing view of subscriptions
  def edit
    @aidatedit = Aidat.find(params[:id])
  end

#Controller method for updating subscriptions
  def update
    @aidatedit = Aidat.find(params[:id])
    if @aidatedit.update_attributes( params[:aidatedit].permit(:year, :month) )
      flash[:success] = "Aidat Düzenlendi"
      redirect_to aidat_path(@aidatedit.daire)
    else
      flash.now[:error] = "Aidat düzenlenemedi, seçilen ay için zaten eklenmiş olabilir!"
      render 'edit'
    end
  end

#Controller method for creating subscriptions
  def create
    @aidat = Aidat.new(aidat_params)
    daire_num = @aidat.daire.to_i

    if !(Renter.find_by(ap_num: daire_num ))#saved from nil check - .nil?
      flash.now[:error] = "Böyle bir kiracı yok. Daire Numarası hatalı."
    else
      if @aidat.save
        flash[:success] = "Aidat Kaydı eklendi"
        redirect_to aidat_path( daire_num )
        return
      else
        flash.now[:error] = "Aidat daha önce eklenmiş."
      end
    end
    
    render 'new'
  end

  private

  # Method for gathering special parameters
  def aidat_params
    params.require(:aidat).permit( :daire, :year, :month)
  end

  # Helper method for giving error about no apartment match found
  def no_daire_error(daire_num)
     if current_user.admin?
        flash.now[:error] = daire_num + " nolu Kiracıya ait ödenmiş aidat yok. Lütfen ekleyin."
        render 'new'
     else
        flash[:error] = daire_num + " nolu Kiracıya ait ödenmiş aidat yok."
        redirect_to root_path
     end
  end
  
end