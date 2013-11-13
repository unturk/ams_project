class RentersController < ApplicationController
  def new
  end
  
  def index
    @renters = Renter.all
  end
  
  def create
  end
  
  def edit
  end
  
  def destroy
  end
end
