#Controller for admin to add,remove,edit the renters
class RentersController < ApplicationController

  before_action :signed_in_user, only: [:index, :new, :create, :edit, :destroy, :update]
  before_action :admin_user, only: [:index, :new, :create, :edit, :destroy, :update]

#Controller method for creating new renter
  def new
    @renter = Renter.new
  end

#Controller method for listing all renters
  def index
    @renters = Renter.all.order('ap_num ASC')
  end

#Contoller method for showing detailed information of the renter
  def show
    @renter = Renter.find(params[:id])
  end

#Controller method for creating new renter
  def create
    @renter = Renter.new(renter_params)
    if @renter.save
      flash[:success] = "Yeni kiracı başarıyla eklendi."
      redirect_to renters_path
    else
      render 'new'
    end
  end

#Controller method for editing the renter
  def edit
    @renter = Renter.find(params[:id])
  end

#Controller method for updating the renter
  def update
    @renter = Renter.find(params[:id])
    if @renter.update_attributes(renter_params)
      flash[:success] = "Kiracı bilgileri güncellendi."
      redirect_to renters_path
    else
      render 'edit'
    end
  end

#Controller method for deleting the renter
  def destroy
    @renter = Renter.find(params[:id])
    Aidat.destroy_all(:daire => ( @renter.ap_num ) )
    @renter.destroy
    flash[:success] = "Kiracı başarıyla silindi."
    redirect_to renters_path
  end

  private
  #Special method for getting specific parameters
    def renter_params
      params.require(:renter).permit(:ap_num, :name, :email, :phone, :meslek, :medeni_durum, :birey_sayisi, :cocuk_sayisi, :memleket, :ev_sahibi, :ev_sahibi_telefon, :kira_miktari)
    end

end