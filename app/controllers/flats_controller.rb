class FlatsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :index, :create, :update, :destroy]

  def index
    @flats = Flat.all
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flats
    else
      render :new
    end
  end

  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
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
