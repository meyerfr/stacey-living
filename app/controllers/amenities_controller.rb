class AmenitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :set_amenity, only: [:show, :edit, :update, :destroy]

  # GET /amenities
  def index
    @amenities = Amenity.all
  end

  # GET /amenities/1
  def show
  end

  # GET /amenities/new
  def new
    @amenity = Amenity.new
  end

  # GET /amenities/1/edit
  def edit
  end

  # POST /amenities
  def create
    @amenity = Amenity.new(name: params[:name], title: params[:title], photo: params[:photo])
    if @amenity.save
      render json: @amenity
    else
      render json: {errors: @amenity.errors.full_messages}
    end
  end

  # PATCH/PUT /amenities/1
  def update
    if @amenity.update(amenity_params)
      redirect_to @amenity, notice: 'Amenity was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /amenities/1
  def destroy
    @amenity.destroy
    redirect_to amenities_url, notice: 'Amenity was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity
      @amenity = Amenity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def amenity_params
      params(:title, :name, :photo)
    end
end
