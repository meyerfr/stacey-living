class ContractsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @room = @booking.room
    @project = @room.project
    @contract = @booking.contracts.new

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract #{@user.first_name} #{@user.last_name}",
        page_size: 'A4',
        template: "contracts/_contract.html.erb",
        layout: "pdf.html",
        zoom: 1
      end
    end
  end

  def create
  end

  def show
  end

  private

  def contracts_params
    params.require(:contract).permit(:signature, :signed_date)
  end
end
