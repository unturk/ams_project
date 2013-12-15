class AidatsController < ApplicationController

  before_action :signed_in_user, only: [:show, :index]
  #before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index, :create, :update, :edit, :new, :destroy]

  def index
    if Renter.all.blank?
      flash[:error] = "Kayıtlı Kiracı Yok. Lütfen Ekleyin."
      redirect_to renters_path
    else
      @renters = Renter.all.order('ap_num ASC')
    end


  end

  def show
    if Aidat.find_by_daire(params[:id]).nil?
      if current_user.admin?
        flash.now[:error] = params[:id] + " nolu Kiracıya ait ödenmiş aidat yok. Lütfen ekleyin."
        render 'new'
      else
        flash[:error] = params[:id] + " daire numaralı kiracıya ait ödenmiş aidat yok."
        redirect_to root_path
      end
    else
      @kiraciaidat = Aidat.find_by_daire(params[:id])
      @gecmis = Aidat.find_all_by_daire(@kiraciaidat.daire)
      @kiraci = Renter.find_by_ap_num( @kiraciaidat.daire)
    end
  end

  def destroy
    @aidatsil = Aidat.find(params[:id])
    if @aidatsil.destroy
      flash.now[:success] = "Aidat Silindi"
      redirect_to aidat_path(@aidatsil.daire)
    else
      redirect_to aidat_path(@aidatsil.daire)
    end
  end

  def new

  end

  def edit
    @aidatedit = Aidat.find(params[:id])
  end

  def update
    @aidatedit = Aidat.find(params[:id])
    if @aidatedit.update_attributes( params[:aidatedit].permit(:year, :month) )
      flash.now[:success] = "Aidat Düzenlendi"
      redirect_to aidat_path(@aidatedit.daire)
    else
      render 'edit'
    end
  end

  def create
    @aidat = Aidat.new(aidat_params)

    if Renter.find_by_ap_num( @aidat.daire ).nil?
      flash.now[:error] = "Böyle bir kiracı yok. Daire Numarası hatalı."
      render 'new'
    else
      if @aidat.save
        flash[:success] = "Aidat Kaydı eklendi"
        redirect_to aidat_path(@aidat.daire)
      else
        flash.now[:error] = "Aidat daha önce eklenmiş."
        render 'new'
      end
    end
  end

  private
  def aidat_params
    params.require(:aidatform).permit( :daire, :year, :month)
  end
end
