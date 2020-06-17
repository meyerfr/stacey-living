class WelcomeCallsController < ApplicationController
  before_action :authenticate_user!, only: %I[index]
  before_action :check_booking_auth_token!, only: %I[new create edit update destroy]
  before_action :calendar_data, only: %I[new edit]

  def index
    @time_param_options = ['past', 'upcoming', 'all']

    @time_param = params[:time].present? ? params[:time] : 'upcoming'
    search_param = params[:search] if params[:search] != ''
    if params[:search] == ''
      @time_param = 'all'
    end
    # if search and time
    @welcome_calls = WelcomeCall.order(:start_time).where("start_time >= ? AND available = ?", Time.now, false)

    if @time_param == 'all'
      @welcome_calls = WelcomeCall.order(:start_time).where(available: false)
    elsif @time_param == 'past'
      @welcome_calls = WelcomeCall.order(:start_time).where("start_time < ? AND available = ?", Time.now, false)
    end


    if search_param
      @welcome_calls = WelcomeCall.order(:start_time).where("name ILIKE ?", "%#{params[:search]}%")
    end

    @dates = []
    if @time_param == 'past'
      @welcome_calls.order(start_time: :desc).each { |call| @dates << call.start_time.to_date unless @dates.include?(call.start_time.to_date) }
      @dates.reverse!
    else
      @welcome_calls.order(start_time: :desc).each { |call| @dates << call.start_time.to_date unless @dates.include?(call.start_time.to_date) }
    end
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @welcome_call = WelcomeCall.find(welcome_calls_params[:id])
    @welcome_call.available = false
    @welcome_call.booking_id = @booking.id
    @welcome_call.name = @user.full_name
    if first_welcome_call?(@booking)
      if @welcome_call.save
        # Send email with all the information
        UserMailer.welcome_call(@welcome_call).deliver_now
        flash[:alert] = "We just send you an email with all informations."
        redirect_to :root
      else
        flash[:alert] = "Oops, something wrent wrong. Please try it again."
        redirect_to new_booking_welcome_call_path(@booking.booking_auth_token, @booking)
      end
    else
      scheduled_welcome_call = WelcomeCall.find_by(booking_id: @booking.id)
      flash[:alert] = "Your call is already scheduled for the #{scheduled_welcome_call.start_time.strftime('%d.%B %Y')} #{scheduled_welcome_call.start_time.strftime('%H:%M')}. Please check your mails."
      # redirect to welcome_call#edit page
      redirect_to new_booking_welcome_call_path(@booking.booking_auth_token, @booking)
    end
  end

  def edit
    @old_welcome_call = WelcomeCall.find(params[:id])
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
  end

  def update
    @old_welcome_call = WelcomeCall.find(params[:id])
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @welcome_call = WelcomeCall.find(welcome_calls_params[:id])
    @welcome_call.available = false
    @welcome_call.booking_id = @booking.id
    @welcome_call.name = @user.full_name
    if @welcome_call.save
      @old_welcome_call.update(name: nil, booking_id: nil, available: true)
      @booking.update(booking_auth_token_exp: @welcome_call.start_time.to_date + 1.day) if @booking.booking_auth_token_exp < @welcome_call.start_time.to_date
      UserMailer.welcome_call_rescheduled(@welcome_call).deliver_now
      flash[:alert] = 'Our call has been reschedueled. Please check your mails'
      redirect_to root_path
    else
      flash[:alert] = "Oops, something wrent wrong. Please try it again."
      redirect_to booking_useredit_welcome_call(@booking.booking_auth_token, @booking, @old_welcome_call)
    end
  end

  def destroy
    @welcome_call = WelcomeCall.find(params[:id])
    if @welcome_call.delete
      flash[:alert] = 'Our call has been canceled.'
      if current_user.admin?
        # send apologize email and a link to schedule a new call
        redirect_to welcome_calls_path
      else
        redirect_to root_path
      end
    else
      flash[:alert] = "Oops, something wrent wrong. Please try it again."
      redirect_to edit_booking_welcome_call(@booking.booking_auth_token, @booking, @welcome_call)
    end
  end

  private

  def welcome_calls_params
    params.require(:welcome_call).permit(
      :id,
      :name,
      :start_time,
      :end_time,
      :available,
      :booking_id
    )
  end

  def date_of_next(day)
    date = Date.parse(day)
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  def find_all_dates
    duration = Date.tomorrow..(Date.today + 9)
    return duration.select{ |day| day.monday? || day.tuesday? || day.wednesday? }
  end

  def array_of_dates(booked_welcome_call_times)
    available_times = []
    find_all_dates.each do |day|
      # finding the first available time slot
      first_available_time = Time.parse("#{day} 10am")
      first_available_time += 30.minutes while booked_welcome_call_times.include?(first_available_time + 1.hour)
      available_times << first_available_time
      # Finding every available time slot
      time_differrence = 30
      while available_times.last + time_differrence.minutes < Time.parse("#{day} 6:30pm")
        next_available_time = available_times.last + time_differrence.minutes
        if booked_welcome_call_times.include?(next_available_time + 1.hour)
          time_differrence = 60
        else
          available_times << next_available_time
          time_differrence = 30
        end
      end
    end
    return available_times
  end

  def first_welcome_call?(booking)
    # returns true if their is no welcome call for this booking in the future
    return_value = true
    booking.welcome_calls.each do |welcome_call|
      welcome_call.start_time.future?
      return_value = false
    end
    return_value
  end

  def calendar_data
    @welcome_calls = WelcomeCall.order(:start_time).select{ |call| call.available == true && call.start_time < Date.today + 9 && call.start_time.to_date > Date.today } # all available WelcomeCalls (@available_times)
    date_params = params[:date].to_date if params[:date]
    if date_params && date_params < Date.today + 9.days
      if @welcome_calls.select{ |call| call.start_time.to_date == date_params }.length.positive?
        @date = date_params
      else
        next_helper = @welcome_calls.select{ |call| call.start_time.to_date > date_params }
        @date = next_helper.any? ? next_helper.first.start_time.to_date : Date.today
      end
    else
      (first_welcome_call = @welcome_calls.select{ |call| call.start_time.to_date > Date.today }.first).present?
      @date = first_welcome_call.present? ? first_welcome_call.start_time.to_date : Date.tomorrow
    end
    @date_available_times = @welcome_calls.select { |call| call.start_time.to_date == @date }
    @month_helper = params[:month].to_date if params[:month]
    @month_param = params[:month] && Date.today <= @month_helper && @month_helper <= Date.today + 9.days ? @month_helper : Date.today
    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end
end
