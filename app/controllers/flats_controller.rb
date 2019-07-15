class FlatsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :show, :create, :update, :destroy]
  before_action :authenticate_user_for_contract_pages!, only: [:index]
  skip_before_action :authenticate_user!, only: [:index]
  layout 'booking', only: [:index]

  def index
    @applicant = User.find(params[:user_id])
    @flats = Flat.all
    @authentity_token_contract = params[:authentity_token_contract]
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flats_path
    else
      render :new
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
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
    params.require(:flat).permit(:project_name, :street, :zipcode, :city, :description, {pictures: []})
  end
end
