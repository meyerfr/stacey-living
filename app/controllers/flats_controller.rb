class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.find(flat_params)
  end

  def update
    @flat.update(flat_params)
    redirect_to @flat
  end

  def destroy
    @flat = Flat.find(params[:id])
    if @flat.destroy
      redirect_to flats_path
    else
      render :edit
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:street, :zipcode, :city)
  end
end
