class Api::V1::UsersController < ActionController::Base
  before_action :set_filter, only: [ :index ]

  def index
    users = @users.map { |user|
      booking = user.bookings.last
      application = user.application
      booking_present = user.bookings.present?
      invite_send = user.bookings.present?
      user.as_json.merge({ full_name: user.full_name, booking: booking, application: application, invite_send: invite_send })
    }

    users = (users.reject{ |u| u[:booking].nil? }.sort_by{ |u| u[:booking][:created_at] } + users.select{ |u| u[:booking].nil? }.sort_by{ |u| u["created_at"]}).reverse

    # users = users.sort_by { |hash| hash['created_at'] }.reverse

    render json: users
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
    filter = params[:filter]
    case filter
    when 'invite'
      case params[:searchquery]
      when 'invite send'
        @users = User.includes(:bookings).where("bookings.state = :state", state: 'booking process invite send').references(:bookings)
      when 'invite outstanding'
        User.joins(:email).where(email: {user_id: nil})
        @users = User.left_outer_joins(:bookings).where( bookings: { id: nil} )
      else
        @users = User.all
      end
    when 'role'
      case params[:searchquery]
      when 'current Tenants'
        @users = User.where(role: 'tenant')
      when 'prev Tenants'
        @users = User.where(role: 'prev tenant')
      when 'applicants'
        @users = User.where(role: 'applicant')
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
      @users = User.last(10)
    end
  end

end
