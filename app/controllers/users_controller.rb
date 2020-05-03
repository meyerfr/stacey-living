class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[new create]

  def all_users
    @users = User.all.where(role: 'applicant')
    raise
  end

  def new
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    @user = User.new
    @user.bookings.build(booking_auth_token: Devise.friendly_token, booking_auth_token_exp: Date.today+2.weeks)
  end

  def create
    @user = User.new(users_params)
    @user.skip_password_validation = true
    # Must delete first element of array, to keep database clean, because its an empty string
    # @user.gender = @user.gender.pop(1) if @user.gender.length.positive?
    # @user.prefered_suite = @user.prefered_suite.pop(1) if @user.prefered_suite.length.positive?
    # @user.first_name = @user.first_name.downcase.titleize
    # @user.last_name = @user.last_name.downcase.titleize
    # @user.email = @user.email.downcase
    # @user.role = 'applicant'
    # if User.exists? @user.email => @user.update
    # need a new welcome mail, if User already exists.
    if @user.save
      @booking = @user.bookings.last
      UserMailer.welcome(@booking).deliver_later(wait_until: 20.minutes.from_now)
      # redirection to calendar page. Schedule welcome call
      redirect_to new_booking_welcome_call_path(@booking.booking_auth_token, @booking, date: Date.today)
    else
      @user.bookings.build(booking_auth_token: Devise.friendly_token, booking_auth_token_exp: Date.today+2.weeks)
      render :new
    end
  end

  def index
    @user_group_param_options = ['applicant', 'tenant', 'all']
    @time_param_options = ['upcoming', 'past', 'all']

    @user_group_param = params[:user_group].present? ? params[:user_group] : 'all'
    @time_param = params[:time].present? ? params[:time] : 'all'

    search_param = params[:search] if params[:search].present?
    # if search and period
    @users = User.all.order(created_at: :desc)
    @users = @users.where(role: @user_group_param) unless @user_group_param == 'all'
    if @time_param == 'future'
      @users = @users.select{ |user| user.bookings.last.move_in.future? || user.bookings.last.move_in.today? if user.bookings.length.positive? }
    elsif @time_param == 'past'
      @users = @users.select{ |user| user.bookings.last.move_in.past? if user.bookings.length.positive? }
    end

    if search_param
      sql_query = " \
        users.first_name @@ :search \
        OR users.last_name @@ :search \
        OR users.email @@ :search \
        OR CONCAT(users.first_name, ' ', users.last_name) @@ :search
      "
      @users = User.where(sql_query, search: "%#{params[:search]}%").order(created_at: :desc)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @countries = ['Australia', 'Austria', 'Belgium', 'Brazil', 'United States', 'China', 'Denmark', 'Finland', 'France', 'Germany', 'Hong Kong', 'Ireland', 'Italy', 'Japan', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Portugal', 'Singapore', 'Spain', 'Sweden', 'Switzerland', 'United Kingdom']
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def users_params
    params.require(:user).permit(
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
      gender: [],
      prefered_suite: [],
      bookings_attributes: [
        :user_id,
        :move_in,
        :move_out,
        :booking_auth_token,
        :booking_auth_token_exp
      ]
    )
  end
end

# def send_invitation_for_contract_pages
#   @user = User.find(params[:user])
#   @flat = Flat.first
#   @authentity_token_contract = Devise.friendly_token
#   @expiration_date = Date.today + 1.week
#   @user.update!(authentity_token_contract: @authentity_token_contract, authentity_token_contract_expiration: @expiration_date)
#   UserMailer.contract_mail(@user, @flat, @authentity_token_contract).deliver_now
#   redirect_to applicants_index_path
# end
