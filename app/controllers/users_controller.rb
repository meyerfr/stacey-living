class UsersController < ApplicationController
  # before_action :authenticate_user_for_contract_pages, only: [:contract]
  before_action :authenticate_admin!, only: [:index, :destroy, :contract]
  skip_before_action :authenticate_user!, only: [:new, :show, :create, :update, :success]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    # raise
    @user.first_name = @user.first_name.capitalize
    @user.last_name = @user.last_name.capitalize
    @user.password = 'stacey-living'
    if @user.save
      send_users_info_via_slack(@user)
      UserMailer.welcome(@user).deliver_now
      # Authenticate a session with your Service Account
      # session = GoogleDrive::Session.from_service_account_key("user_secret.json")
      # # Get the spreadsheet by its title
      # spreadsheet = session.spreadsheet_by_title("STACEY Users")
      # # Get the first worksheet
      # worksheet = spreadsheet.worksheets.first

      # worksheet.insert_rows(worksheet.num_rows + 1, [[@user.first_name, @user.last_name, @user.email, @user.phone_code, @user.phone, @user.date_of_birth.strftime('%d.%m %Y'), @user.job, @user.move_in_date.strftime('%d.%m %Y'), @user.duration_of_stay.strftime('%d.%m %Y'), @user.amount_of_people]])
      # if @user.move_in_date > Date.new(2019, 9, 1) && !@user.prefered_suite.include?('Premium') && !@user.prefered_suite.include?('Jumbo')
      #   UserMailer.waiting_list_mail(@user).deliver_now
      # elsif @user.prefered_suite.include?('Basic +') && !@user.prefered_suite.include?('Premium') && !@user.prefered_suite.include?('Jumbo')
      #   UserMailer.no_basic_suite_mail(@user).deliver_now
      # else
      #   UserMailer.welcome(@user).deliver_now
      # end
      # later(wait_until: 8.minutes.from_now)
      redirect_to users_success_path
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def updateapplicant
    @user = User.find(params[:user_id])
    @flat = Flat.find(params[:flat_id])
    @room = Room.find(params[:room_id])
    @authentity_token_contract = params[:authentity_token_contract]
    if @user.update(users_params)
      # Booking probably must be created here
      redirect_to user_contract_new_path(@user, @flat, @room, @authentity_token_contract)
    else
      render user_room_path(@user, @flat, @room, @authentity_token_contract)
    end
  end

  def updateapplicantpayment
    @applicant = User.find(Booking.find(params[:booking_id]).user.id)
    @applicant.update(users_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to applicants_index_path
  end

  def applicants
    @users = User.all.where(applicant: true)
  end

  def send_invitation_for_contract_pages
    @user = User.find(params[:user])
    @flat = Flat.first
    @authentity_token_contract = Devise.friendly_token
    @expiration_date = Date.today + 1.week
    @user.update!(authentity_token_contract: @authentity_token_contract, authentity_token_contract_expiration: @expiration_date)
    UserMailer.contract_mail(@user, @flat, @authentity_token_contract).deliver_now
    redirect_to applicants_index_path
  end

  def contract
    @rooms = Room.all
    @user = User.first
    @flat = Flat.first
  end

  def updatespreadsheet
    # Authenticate a session with your Service Account
    session = GoogleDrive::Session.from_service_account_key("user_secret.json")
    # Get the spreadsheet by its title
    spreadsheet = session.spreadsheet_by_title("STACEY Users")
    # Get the first worksheet
    worksheet = spreadsheet.worksheets.first
    # Print out the first 6 columns of each row
    applicants = User.all.where(applicant: true)
    #Delete worksheet cells
    worksheet.delete_rows(3, applicants.length + 3)
    worksheet["B2"] = Time.now.strftime('%d.%m %Y (%k:%M)')
    #inserting all applicants in spreadsheet
    applicants.each do |applicant|
      worksheet.insert_rows(worksheet.num_rows + 1, [[applicant.first_name, applicant.last_name, applicant.email, applicant.phone_code, applicant.phone, applicant.date_of_birth.strftime('%d.%m %Y'), applicant.job, applicant.move_in_date.strftime('%d.%m %Y'), applicant.duration_of_stay.strftime('%d.%m %Y'), applicant.amount_of_people]])
    end
    worksheet.save
    redirect_to applicants_index_path
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_code, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, :linked_in, :facebook, :twitter, :instagram, :photo, { :prefered_suite => [] })
  end

  def authenticate_user_for_contract_pages
    user = User.find(params[:id])
    if user.authentity_token_contract == params[:authentity_token_contract]
      if !user.authentity_token_contract_expiration.future?
        flash[:alert] = "Please sign in first"
        redirect_to new_user_path
      end
    else
      flash[:alert] = "Your not allowed to access this page"
      redirect_to new_user_path
    end
  end

  def send_users_info_via_slack(user)
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: '#applicants',
      text: "We have a new Applicant. At the moment we have #{User.all.where(applicant: true).count},
      Name: #{user.first_name} #{user.last_name},
      Email: #{user.email},
      Phone: #{user.phone_code} #{user.phone},
      Geburtstag: #{user.date_of_birth},
      Job: #{user.job},
      Einzugsdatum: #{Date.new(user.move_in_date[1], user.move_in_date[2], user.move_in_date[3])},
      Zeitraum: #{Date.new(user.duration_of_stay[1], user.duration_of_stay[2], user.duration_of_stay[3])},
      Anzahl an Leuten: #{user.amount_of_people},
      Interessiert an: #{user.prefered_suite.join(', ')}",
      as_user: true
    )
  end
end
