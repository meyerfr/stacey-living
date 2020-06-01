class Booking::ProcessController < ApplicationController
  include Wicked::Wizard
  steps *Booking.form_steps

  before_action :set_objects, except: [:apply]
  layout "bookingprocess", except: [:apply]
  def apply
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    @booking = Booking.new(booking_auth_token: Devise.friendly_token, booking_auth_token_exp: Date.today+2.weeks)
    @booking.build_user
    ['Facebook', 'LinkedIn', 'Instagram', 'Twitter'].each do |social_link_name|
      @booking.user.social_links.build(name: social_link_name)
    end
    Roomtype.order(:size).uniq{|roomtype| roomtype.name}.each do |roomtype|
      @booking.user.prefered_suites.build(roomtype_id: roomtype.id)
    end
  end

  def create
    @booking = Booking.new(booking_params(nil))
    @booking.user.skip_password_validation = true
    if @booking.save
      redirect_to new_booking_welcome_call_path(@booking.booking_auth_token, @booking)
    else
      render :apply
    end
  end

  def show
    set_nested_attributes
    render_wizard
  end

  def update
    raise
    if step == 'room'
      @room = Room.find(params[:booking][:room_id])
      @booking.move_in = @room.bookings.present? ? @room.bookings.last.move_out : Date.tomorrow
    end
    # if step == 'payment'
      # @booking.status = 'completed'
      # @booking.stripe_subscription_plan_id = create_stripe_subscription
    # end
    if @booking.update!(booking_params(step))
      # if step == 'payment'
        # @booking.status == 'active'
        # render_wizard
      # else
      redirect_to(next_wizard_path)
      # end
    else
      set_nested_attributes
      render_wizard @booking
    end
    # raise
  end

  private

  def set_objects
    @booking = Booking.find(params[:booking_id]) unless step == 'apply'
    case step
    when 'rooms'
      @project = Project.find(params[:project_id])
    # when 'room'
    #   @roomtype = Roomtype.find(params[:roomtype_id])
    #   @project = @roomtype.project
    end
  end

  def set_nested_attributes
    case step
    when 'projects'
      @projects = Project.last(1)
      @markers = @projects.map do |project|
        {
          lat: project.address.latitude,
          lng: project.address.longitude,
          # infoWindow: render_to_string(partial: 'info_window', locals: { user: user }),
          image_url: helpers.asset_url('maps_marker.png')
        }
      end
      @project_index_amenities = []
      Project.last.join_amenities.each{|ja| @project_index_amenities << ja.amenity if ja.name == 'project index' }
    when 'rooms'
      @roomtypes = @project.roomtypes
      @project_show_amenities = []
      @project.join_amenities.each{|ja| @project_show_amenities << ja.amenity if ja.name == 'project show' }
      @room_availability_hash = find_available_booking_dates_for_each_room_art(@roomtypes)
      @markers = [
        {
          lat: @project.address.latitude,
          lng: @project.address.longitude,
          # infoWindow: render_to_string(partial: 'info_window', locals: { user: user }),
          image_url: helpers.asset_url('maps_marker.png')
        }
      ]
    when 'room'
      @roomtype = Roomtype.find(params[:roomtype_id])
      @project = @roomtype.project
      @roomtype_show_amenities = []
      @roomtype.join_amenities.each{|ja| @roomtype_show_amenities << ja.amenity if ja.name == 'roomtype show' }

      @room_availability = {}
      @roomtype.rooms.each do |room|
        rooms_last_booking = Booking.order(:move_out).select{ |b| b.room == room && b.state == 'booked' }.last
        if rooms_last_booking.present? && rooms_last_booking.move_out.future?
          @room_availability.store(room.id, (rooms_last_booking.move_out + 1.day).strftime('%d. %B %Y')) if !@room_availability.values.include?((rooms_last_booking.move_out + 1.day).strftime('%d. %B %Y'))
        else
          @room_availability.store(room.id, Date.tomorrow.strftime('%d. %B %Y')) if !@room_availability.values.include?(Date.tomorrow.strftime('%d. %B %Y'))
        end
      end
      @room_availability = @room_availability.sort_by { |key, value| value.to_date }.to_h
      @markers = [
        {
          lat: @project.address.latitude,
          lng: @project.address.longitude,
          # infoWindow: render_to_string(partial: 'info_window', locals: { user: user }),
          image_url: helpers.asset_url('maps_marker.png')
        }
      ]
    when 'contract_new'
      @booking.build_contract unless @booking.contract.present?
      @booking.user.build_address unless @booking.user.address.present?
      @countries = ['Australia', 'Austria', 'Belgium', 'Brazil', 'United States', 'China', 'Denmark', 'Finland', 'France', 'Germany', 'Hong Kong', 'Ireland', 'Italy', 'Japan', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Portugal', 'Singapore', 'Spain', 'Sweden', 'Switzerland', 'United Kingdom']
    when 'payment'
      @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
      set_price_and_deposit
    end
  end

  def booking_params(step)
    permitted_attributes = if request.path_parameters[:action] != 'create'
                             case step
                             when "apply"
                               [
                                :name,
                                {photos: []},
                                descriptions_attributes: [
                                                          :id,
                                                          :field,
                                                          :content
                                                         ],
                                project_amenities_attributes: [
                                                               :id,
                                                               :amenity_id,
                                                               :_destroy
                                                              ]
                               ]
                             when "address"
                               [
                                address_attributes: [
                                                     :id,
                                                     :addressable_id,
                                                     :street,
                                                     :number,
                                                     :zip,
                                                     :city,
                                                     :country,
                                                     description_attributes: [
                                                                              :id,
                                                                              :descriptionable_id,
                                                                              :field,
                                                                              :content
                                                                             ]
                                                    ]
                               ]
                             when "rooms"
                               [
                                roomtypes_attributes: [
                                                       :_destroy,
                                                       :id,
                                                       :name,
                                                       :size,
                                                       {photos: []},
                                                       rooms_attributes: [
                                                                          :id,
                                                                          :_destroy,
                                                                          :intern_number,
                                                                          :house_number
                                                                         ],
                                                       descriptions_attributes: [
                                                                                 :id,
                                                                                 :field,
                                                                                 :content
                                                                                ],
                                                       prices_attributes: [
                                                                           :id,
                                                                           :duration,
                                                                           :amount
                                                                          ]
                                                       ]
                               ]
                             when 'room'
                               [
                                :room_id,
                                :move_out
                               ]
                             when 'contract_new'
                               [
                                user_attributes: [
                                                  :id,
                                                  address_attributes: [
                                                                       :id,
                                                                       :street,
                                                                       :number,
                                                                       :city,
                                                                       :zip,
                                                                       :country
                                                                      ]
                                                 ],
                                contract_attributes: [
                                                      :id,
                                                      :signature,
                                                      :signed_date
                                                     ]
                               ]
                             end
                           else
                             [
                               :move_in,
                               :move_out,
                               user_attributes: [
                                 :first_name,
                                 :last_name,
                                 :email,
                                 :phone_code,
                                 :phone_number,
                                 :dob,
                                 :job,
                                 :street,
                                 :city,
                                 :zipcode,
                                 :country,
                                 :amount_of_people,
                                 :linkedin,
                                 :facebook,
                                 :twitter,
                                 :instagram,
                                 :photo,
                                 :gender,
                                 social_links_attributes: [
                                   :name,
                                   :url,
                                   :_destroy
                                 ],
                                 prefered_suites_attributes: [
                                   :roomtype_id,
                                   :_destroy
                                 ]
                               ]
                             ]
                           end

    params.require(:booking).permit(permitted_attributes).merge(form_step: step)
  end

  def find_available_booking_dates_for_each_room_art(roomtypes)
    availability = {}
    roomtypes.each do |type|
      lastBookingId = Booking.select{ |b| b.state == 'booked' && b.move_out >= Date.today && b.room.roomtype.name.delete(' ').downcase == type.name.delete(' ').downcase if b.room.present? }.last
      if lastBookingId.present?
        availability.store(type.name, (lastBookingId.move_out + 1.day).strftime('%d.%B %Y'))
      else
        availability.store(type.name, 'today')
      end
    end
    availability
  end

  def set_price_and_deposit
    @roomtype = @booking.room.roomtype
    move_in = @booking.move_in
    move_out = @booking.move_out
    duration = (move_out.year - move_in.year) * 12 + move_out.month - move_in.month - (move_out.day >= move_in.day ? 0 : 1)
    if duration <= 5
      @price = @roomtype.prices.first.amount
    else
      @price = @roomtype.prices.last.amount
    end
    @booking_fee = 80
    @total_today = @booking_fee + (@price * 2)
    # @total_amount = @deposit + 80
  end
end
