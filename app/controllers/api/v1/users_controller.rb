class Api::V1::UsersController < ActionController::Base
  before_action :set_filter, only: [ :index ]

  USERS_PER_PAGE = 30

  def index
    users = @users.reverse_order.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE)

    users = users.map { |user|
      booking = user.bookings.last
      application = user.application
      booking_present = user.bookings.present?
      invite_send = user.bookings.present?
      user.as_json.merge({ full_name: user.full_name, booking: booking, application: application, invite_send: invite_send })
    }

    # users = (users.reject{ |u| u[:booking].nil? }.sort_by{ |u| u[:booking][:created_at] } + users.select{ |u| u[:booking].nil? }.sort_by{ |u| u["created_at"]})

    # users = users.sort_by { |hash| hash['created_at'] }.reverse

    render json: {
      users: users,
      pagination: {
        page: params.fetch(:page, 0).to_i,
        pages: @users.count / USERS_PER_PAGE
      },
      filter: {
        filterKey: params.fetch(:filter, nil),
        searchquery: params.fetch(:searchquery, nil)
      }
    }
  end

	def update
		user = User.find(params[:id])
		user.update!(users_params)
		render json: user
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
      :gender,
      :amount_of_people
    )
	end

  def set_filter
    @page = params.fetch(:page, 0).to_i
    # availabilities = availabilities_inside_timerange(@start_time_query, @end_time_query)
    # @page_count = availabilities.count / SITTERS_PER_PAGE
    # @users = users


    filter = params[:filter]
    case filter
    when 'invite'
      case params[:searchquery]
      when 'invite send'
        @users = User.includes(:bookings).where("bookings.state = :state", state: 'booking process invite send').references(:bookings)
      when 'invite outstanding'
        @users = User.left_outer_joins(:bookings).where( bookings: { id: nil} )
      else
        @users = User.all
      end
    when 'role'
      case params[:searchquery]
      when 'current Tenants'
        @users = User.left_outer_joins(:bookings).where("bookings.state = :state AND bookings.move_in <= :todays_date AND bookings.move_out >= :todays_date", state: 'booked', todays_date: Date.today)
      when 'prev Tenants'
        @users = User.left_outer_joins(:bookings).where("bookings.state = :state AND bookings.move_out <= :todays_date", state: 'booked', todays_date: Date.today)
      when 'next Tenants'
        @users = User.left_outer_joins(:bookings).where("bookings.state = :state AND bookings.move_in >= :todays_date", state: 'booked', todays_date: Date.today)
      when 'applicants'
        @users = User.where(role: 'applicant').where.not(application: nil).joins(:application).order("applications.created_at")
      end

    when 'name'
      sql_query = " \
        users.first_name @@ :search \
        OR users.last_name @@ :search \
        OR users.email @@ :search \
        OR CONCAT(users.first_name, ' ', users.last_name) @@ :search
      "
      @users = User.where(sql_query, search: "%#{params[:searchquery]}%").order(created_at: :desc)
    else
      @users = User.includes(:application).order('applications.created_at')
    end
  end

end
