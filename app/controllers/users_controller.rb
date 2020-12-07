class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[new create]

  USERS_PER_PAGE = 25

  def all_users
    @users = User.all
    send_data @users.to_csv_test, filename: "users-#{Date.today}.csv"
  end

  def index
    @user_group_param_options = ['all', 'applicant', 'tenant']
    @time_param_options = ['all', 'upcoming', 'past']

    @user_group_param = params.fetch(:user_group, 'all')
    @time_param = params.fetch(:time, 'all')

    search_param = params[:search] if params[:search].present?
    # if search and period
    @users = User.all.order(created_at: :desc)
    @users = @users.where(role: @user_group_param) unless @user_group_param == 'all'
    if @time_param == 'future'
      @users = @users.includes(:bookings).where("bookings.move_in >= :todays_date", todays_date: Date.today).references(:bookings)
    elsif @time_param == 'past'
      @users = @users.includes(:bookings).where("bookings.move_in < :todays_date", todays_date: Date.today).references(:bookings)
    end
    # @users = @users.uniq

    if search_param
      sql_query = " \
        users.first_name @@ :search \
        OR users.last_name @@ :search \
        OR users.email @@ :search \
        OR CONCAT(users.first_name, ' ', users.last_name) @@ :search
      "
      @users = User.where(sql_query, search: "%#{params[:search]}%").order(created_at: :desc)
    end
    @page = params.fetch(:page, 0).to_i
    @page_count = @users.count / USERS_PER_PAGE
    @users = @users.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
    @page = params.fetch(:page)
    # @last_booking = @user.bookings.last
    # @prefered_suites = @user.prefered_suites
    # @address = @user.address if @user.address.present?
    respond_to do |format|
      format.html { render 'users/show' }
      format.js # <-- will render `app/views/users/show.js.erb`
    end
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
      :gender,
      social_links_attributes: [
        :name,
        :url,
        :_destroy
      ],
      prefered_suites_attributes: [
        :roomtype_id,
        :_destroy
      ],
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
