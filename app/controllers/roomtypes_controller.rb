class RoomtypesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  before_action :check_booking_auth_token!, only: [:index, :show]
  # layout "bookingprocess", only: [:index, :show]
  layout "overview", only: [:index, :show]

  def index
    
  end

  def show
    
  end

  def destroy
    @roomtype = Roomtype.find(params[:id])
    if @roomtype.delete
      flash[:alert] = "Room successfully deleted."
    else
      flash[:alert] = "Oops something went wrong. Please try again."
    end
    redirect_to roomtypes_path
  end

  def roomtpye_prices

  end

  private

  def roomtypes_params
    params.require(:roomtypes).permit(
      :project_id,
      :number,
      :name,
      :size,
      :description,
      price: [],
      pictures: [],
      room_amenities_attributes: [:amenity_id]
    )
  end
end
