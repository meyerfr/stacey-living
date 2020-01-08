class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    @user = User.new
    @user.bookings.new
  end

  def create
    @user = User.new(users_params)
    @user.skip_password_validation = true
    # Must delete first element of array, to keep database clean, because its an empty string
    @user.gender = @user.gender.pop(1) if @user.gender.length.positive?
    @user.prefered_suite = @user.prefered_suite.pop(1) if @user.prefered_suite.length.positive?
    @user.first_name = @user.first_name.capitalize
    @user.last_name = @user.last_name.capitalize
    @user.email = @user.email.downcase
    @user.role = 'applicant'
    if @user.save
      # create booking. Validation and correct duration has been checked
      move_in_helper_array = users_params[:bookings_attributes]['0'].values.first(3).map! { |e| e.to_i }.reverse
      move_in_date = Date.new(move_in_helper_array[0], move_in_helper_array[1], move_in_helper_array[2])
      move_out_helper_array = users_params[:bookings_attributes]['0'].values.last(3).map! { |e| e.to_i }.reverse
      move_out_date = Date.new(move_out_helper_array[0], move_out_helper_array[1], move_out_helper_array[2])
      @booking = @user.bookings.new(move_in: move_in_date, move_out: move_out_date)
      @booking.booking_auth_token = Devise.friendly_token
      @booking.booking_auth_token_exp = Date.today + 1.week
      @booking.save

      UserMailer.welcome(@booking).deliver_later(wait_until: 20.minutes.from_now)
      # redirection to calendar page. Schedule welcome call
      redirect_to booking_book_welcome_call_path(@booking.booking_auth_token, @booking, date: Date.today)
    else
      @user.bookings.new
      render :new
    end
  end

  def index
    user_group_param = params[:user_group] if params[:user_group].present?
    search_param = params[:search] if params[:search].present?
    # if search and period
    @users = User.all

    if user_group_param
      if user_group_param == 'applicants'
        @users = User.all.where(role: 'applicant').order(created_at: :desc)
      elsif user_group_param == 'tenants'
        @users = User.all.where(role: 'tenant').order(created_at: :desc)
      end
    end
    if search_param
      sql_query = " \
        users.first_name @@ :search \
        OR users.last_name @@ :search \
        OR users.email @@ :search \
      "
      @users = User.where(sql_query, search: "%#{params[:search]}%").order(created_at: :desc)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
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
      bookings_attributes: Booking.attribute_names.map(&:to_sym).push(:_destroy)
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
