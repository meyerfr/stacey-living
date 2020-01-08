class WelcomeCallsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!, only: %I[new create edit update destroy]

    # destroy(for user and admin, if admin cancels user gets appologize_mail, if user cancels send slack message)
    # think about: when admin cancels, send new timeslot suggestion or just link to select a new one

  # index view is the view where the user can choose a slot for his/her welcome call
  def index
    # @welcome_calls = WelcomeCall.all.where(available: false)
    period_param = params[:period] if params[:period]
    search_param = params[:search] if params[:search]
    # if search and period
    @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ?", Time.now, false)

    if period_param == 'upcoming'
      @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ?", Time.now, false)
    elsif period_param == 'past'
      @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ?", Time.now, false)
    end

    if search_param
      @welcome_calls = WelcomeCall.all.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # if search_param && period_param
    #   if period_param == 'upcoming' # all upcoming calls
    #     @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
    #   else # all past calls
    #     @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
    #   end
    # elsif search_param
    #   @welcome_calls = WelcomeCall.all.where("lower(name) = ?", search_param.downcase)
    # end

    @dates = []
    @welcome_calls.each { |call| @dates << call.start_time.to_date unless @dates.include?(call.start_time.to_date) }
    # @date = params[:date].to_date if present?
    # @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    # @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    booked_welcome_call_times = []
    WelcomeCall.all.where("start_time > ? AND available = ?", Date.today, false).each{ |call| booked_welcome_call_times << call.start_time }
    @available_times = array_of_dates(booked_welcome_call_times)
    # @welcome_calls = WelcomeCall.all.where("start_time > ? AND start_time < ? AND available = ?", (Date.today + 1.day), (Date.today + 9.days), true)
    date_params = params[:date].to_date if params[:date]
    if date_params && date_params < Date.today + 10.days
      if @available_times.select { |available_time| available_time.to_date == date_params }.length.positive?
        @date = date_params
      else
        next_helper = @available_times.select { |available_time| available_time.to_date > date_params }
        @date = next_helper.any? ? next_helper.first.to_date : Date.today
      end
    else
      @date = @available_times.select { |available_time| available_time.to_date > Date.today }.first.to_date
    end

    @date_available_times = @available_times.select { |available_time| available_time.to_date == @date } if @available_times.select { |available_time| available_time.to_date == @date }.length.positive?

    @month_helper = params[:month].to_date if params[:month]
    @month_param = params[:month] && Date.today <= @month_helper && @month_helper <= Date.today + 9.days ? @month_helper : Date.today

    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @welcome_call = WelcomeCall.new(welcome_calls_params)
    @welcome_call.start_time = @welcome_call.start_time + 1.hour
    @welcome_call.end_time = @welcome_call.end_time + 1.hour
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
    @booking = @old_welcome_call.booking
    @user = @booking.user
    booked_welcome_call_times = []
    WelcomeCall.all.where("start_time > ? AND available = ?", Date.today, false).each{ |call| booked_welcome_call_times << call.start_time }
    @available_times = array_of_dates(booked_welcome_call_times)
    # @welcome_calls = WelcomeCall.all.where("start_time > ? AND start_time < ? AND available = ?", (Date.today + 1.day), (Date.today + 9.days), true)
    date_params = params[:date].to_date if params[:date]
    if date_params && date_params < Date.today + 9.days
      if @available_times.select { |available_time| available_time.to_date == date_params }.length.positive?
        @date = date_params
      else
        next_helper = @available_times.select { |available_time| available_time.to_date > date_params }
        @date = next_helper.any? ? next_helper.first.to_date : Date.today
      end
    else
      @date = @available_times.select { |available_time| available_time.to_date > Date.today }.first.to_date
    end

    @date_available_times = @available_times.select { |available_time| available_time.to_date == @date } if @available_times.select { |available_time| available_time.to_date == @date }.length.positive?

    @month_helper = params[:month].to_date if params[:month]
    @month_param = params[:month] && Date.today <= @month_helper && @month_helper <= Date.today + 9.days ? @month_helper : Date.today

    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def update
    @old_welcome_call = WelcomeCall.find(params[:id])
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @welcome_call = WelcomeCall.new(welcome_calls_params)
    @welcome_call.start_time = @welcome_call.start_time + 1.hour
    @welcome_call.end_time = @welcome_call.end_time + 1.hour
    @welcome_call.available = false
    @welcome_call.booking_id = @booking.id
    @welcome_call.name = @user.full_name
    if @welcome_call.save
      if !current_user.admin?
        # send apologize email and ask if the new date is okay? and link to reschedule call

      # else
        # send email with info to the new call
        UserMailer.welcome_call_rescheduled(@welcome_call).deliver_now
      end
      @old_welcome_call.delete
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
  # def array_of_dates
  #   available_times = []
  #   ['Saturday', 'Tuesday', 'Wednesday'].each do |date|
  #     available_times << Time.parse("#{date_of_next(date)} 10am")
  #     while available_times.last + 30.minutes < Time.parse("#{date_of_next(date)} 18:30pm")
  #       available_times << available_times.last + 30.minutes
  #     end
  #   end
  #   return available_times
  # end
end
