class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_call.subject
  #
  before_action :set_logo_attachment

  # Invite to booking process is beeing send
  def invite_for_booking_process(booking)
    @booking = booking
    @user = booking.user
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Stacey - coliving - booking process')
  end

  # reminder for booking process is beeing send if booking is not completed after 5 and 10 days
  def booking_process_reminder(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY - coliving - booking process reminder")# do |format|
  end

  # send booking summary + request to send deposit
  def booking_process_completed(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    @room = booking.room
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - deposit outstanding")# do |format|
  end

  # notive that deposit has been received and the room is ready to move in on the move_in date
  def deposit_received(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    @room = booking.room
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - deposit received")# do |format|
  end

  # notice that deposit has not been received in time
  def deposit_not_received(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    @room = booking.room
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - deposit not received")# do |format|
  end

  # welcome tenant to stacey community 1 week before move_in + all information for move in
  def welcome_one_pager(booking)
    @booking = booking
    @room = booking.room
    @roomtype = @room.roomtype
    @project = @room.project
    @user = booking.user
    project_address = @project.address
    @address = "#{project_address.street} #{@room.house_number.split(" ").first}, #{project_address.zip} #{project_address.city}, #{@room.house_number.split(" ").drop(1).join(" ")} (STACEY#{@room.apartment_number && " #{@room.apartment_number}"}})"

    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    attachments['welcome_one_pager.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "Welcome One-Pager", template: 'documents/welcome_one_pager.html.erb', layout: 'pdf')
    )
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - welcome")# do |format|
  end

  # ask tenant if they want to extend the stay + request to answer to this email with according dates
  def extend_booking(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    @room = booking.room
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - extend stay")# do |format|
  end

  # request to rate the stay at STACEY
  def rate_booking(booking)
    @booking = booking
    @user = booking.user
    @roomtype = booking.roomtype
    @room = booking.room
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "STACEY #{booking.project.name} - rate your stay")# do |format|
  end

  private

  def set_logo_attachment
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/stacey_logo_pink.png")
  end
end
