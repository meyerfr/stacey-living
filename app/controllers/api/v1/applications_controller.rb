require 'rest-client'
require 'json'

class Api::V1::ApplicationsController < ActionController::Base

  def create
    user = User.find_by(email: applications_params[:user_attributes][:email])
    if user.present?
      application = user.build_application(applications_params.except(:user_attributes))
      # pipedrive_person_id = user.pipedrive_person_id
      # create Deal in Pipedrive
    else
      application = Application.new(applications_params)

      application.user.skip_password_validation = true
    end

    if application.save!
      user = application.user

      if user.pipedrive_person_id
        # create Deal
        create_pipedrive_deal(user)
      else
        # create Person
        create_pipedrive_person(user)

        # create Deal
        create_pipedrive_deal(user)
      end

      UserMailer.welcome(application.user).deliver_later(wait_until:  2.minutes.from_now)
      render json: application
      # redirect_to new_booking_welcome_call_path(booking.booking_auth_token, booking)
    else
      render json: application.errors
    end
  end

  private

  def applications_params
    params.require(:application).permit(
      :move_in,
      :move_out,
      :prefered_suite,
      :prefered_location,
      user_attributes: [
        :first_name,
        :last_name,
        :email,
        :dob,
        :phone_code,
        :phone_number
      ]
    )
  end

  def create_pipedrive_person(user)
    return unless user.present? || user.pipedrive_person_id.nil?

    res_person = RestClient.post(
      url('persons'),
      {
        "name": user.full_name,
        "email": [ { "label": "home", "value": user.email, "primary": true } ],
        "phone": [ { "label": "mobile", "value": "#{user.phone_code} #{user.phone_number}", "primary": true } ]
      }.to_json,
      {content_type: :json, accept: :json}
    )
    repos_person = JSON.parse(res_person)

    pipedrive_person_id = repos_person['data']['id']

    user.update(pipedrive_person_id: pipedrive_person_id)
  end

  def create_pipedrive_deal(user)
    return unless user.present?

    application = user.application

    # create Deal
    res_deal = RestClient.post url('deals'), {"title": "#{user.full_name} Deal", "person_id": user.pipedrive_person_id, "stage_id": 11, "add_time": user.created_at.strftime('%Y-%m-%d %H:%M:%S')}.to_json, {content_type: :json, accept: :json}
    repos_deal = JSON.parse(res_deal)
    pipedrive_deal_id = repos_deal['data']['id']

    application.update(pipedrive_deal_id: pipedrive_deal_id)

    # add Note to Deal
    move_in = "am #{application.move_in}"
    move_out = "so lange wie möglich"

    if ['30 days', '60 days'].include? application.move_in
      move_in = "in #{application.move_in.first(2)} Tagen"
    end

    if ['3-5 Months', '6-8 Months', '9+ Months'].include? application.move_in
      move_out = "ca #{application.move_in.first(3)} Monate"
    end

    content = "<div>Möchte gerne <b>#{move_in}</b> einziehen und <b>#{move_out}</b> bleiben.</div><br><div>Würde am liebsten nach <b>#{application.prefered_location}</b> ziehen</div>"
    RestClient.post url('notes'), {"content": content, deal_id: pipedrive_deal_id}.to_json, {content_type: :json, accept: :json}
  end


  def url(action)
    "https://api.pipedrive.com/v1/#{action}?api_token=#{ENV['PIPEDRIVE_API_TOKEN']}"
  end
end
