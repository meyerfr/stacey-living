class RoomsController < ApplicationController
  # before_action :set_params
  layout "overview", only: [:index]

  def index
    @bookings = Booking.where(
              "bookings.move_in <= :todays_date AND move_out >= :todays_date AND state = :booked_state",
              todays_date: Date.today,
              booked_state: 'booked'
            ).order(:move_in)

    @bookings = @bookings.map { |booking|
      roomtype = booking.roomtype
      room = booking.room
      user = booking.user
      booking.as_json.merge({ project_name: booking.project.name, user_name: user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
    }#.sort_by{|b|b[:move_in]}
    # @rooms = Room.all.order(:intern_number)
  end

  private

  def set_params
    @project = Project.find_by(params[:project_id]) if params[:project_id]

  end
end
