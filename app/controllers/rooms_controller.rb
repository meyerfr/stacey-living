class RoomsController < ApplicationController
  # before_action :set_params
  layout "overview", only: [:index]

  def index
    # must include, roomtype.name, project.name, booking.start_date, booking.end_date, user.full_name, room.apartment_id
    roomtype_name = params[:roomtype_name]
    project_id = params[:project_id]
    room_id = params[:room_id]
    apartment_id = params[:apartment_id]
    time = params[:time]

    if project_id
      if roomtype_name
        @bookings = Project.find(project_id).roomtypes.find_by(name: roomtype_name).bookings.where(state: 'booked')
      else
        @bookings = Project.find(project_id).bookings.where(state: 'booked')
      end
    else
      @bookings = Booking.all.where(state: 'booked')
    end

    # @bookings = Booking.select do |b|
    #   b.project_id == project_id if project_id &&
    #   b.roomtpye.name = roomtpye_name if 
    # end
    @bookings = @bookings.map { |booking|
      roomtype = booking.roomtype
      room = booking.room
      user = booking.user
      booking.as_json.merge({ project_name: booking.project.name, user_name: user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
    }.sort_by{|b|b[:room_number]}
    # @rooms = Room.all.order(:intern_number)
  end

  private

  def set_params
    @project = Project.find_by(params[:project_id]) if params[:project_id]

  end
end
