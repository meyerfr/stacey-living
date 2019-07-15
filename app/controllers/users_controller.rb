class UsersController < ApplicationController
  # before_action :authenticate_user_for_contract_pages, only: [:contract]
  before_action :authenticate_admin!, only: [:index, :destroy, :contract]
  skip_before_action :authenticate_user!, only: [:new, :show, :create, :update, :success]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    @user.first_name = @user.first_name.capitalize
    @user.last_name = @user.last_name.capitalize
    @user.password = 'stacey-living'
    if @user.save
      UserMailer.welcome(@user).deliver_now
      # later(wait_until: 8.minutes.from_now)
      send_users_info_via_slack(@user)
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


  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_code, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, :linked_in, :facebook, :twitter, :instagram, :photo)
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
      Einzugsdatum: #{user.move_in_date},
      Zeitraum: #{user.duration_of_stay},
      Anzahl an Leuten: #{user.amount_of_people}",
      as_user: true
    )
  end
end
