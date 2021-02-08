require 'rest-client'
require 'json'

class Api::V1::WebhooksController < ActionController::Base
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def pipedrive_webhook
    begin
      event = JSON.parse(request.body.read)
      # return unless event['current']["title"] == "Fritz Meyer Deal"
      return unless event['meta']['change_source'] == 'app'
      deal_id = event['meta']['id']
      deal = Booking.find_by(pipedrive_deal_id: deal_id) || Application.find_by(pipedrive_deal_id: deal_id)

      if event['current']['status'] == 'lost'
        deal.update(state: 'lost')
      else
        if event['meta']['object'] == 'deal'

          current_stage = event['current']['stage_id']

          state = find_correct_state(current_stage)

          case state
          # when 'Google Bewertung abgeben'
          #   # this must send out an Email of some sort which leads to them to rate Stacey on Google

          # when ["info mail send", "2. Call", "3. Call", "wait for customer response"]
          #   deal.update(state: state) if deal.class == Application
          when 'invite send'
            # send Booking process invite
            user = deal.user
            pipedrive_deal_id = application.pipedrive_deal_id
            booking = user.bookings.new(
              state: 'invite send',
              booking_auth_token: Devise.friendly_token,
              booking_auth_token_exp: Date.today+2.weeks,
              pipedrive_deal_id: pipedrive_deal_id
            )
            # booking.user.skip_password_validation = true
            BookingMailer.invite_for_booking_process(booking).deliver_now if booking.save!

            content = "<div>Eingeladen zum Buchungsprozess am <b>#{Date.today.stftime('%d.%B %Y')}</b></div>"
            RestClient.post(
              pipedrive_api_url('notes'),
              {
                "content": content,
                deal_id: pipedrive_deal_id
              }.to_json,
              {
                content_type: :json,
                accept: :json
              }
            )
          when 'deposit received'
            BookingMailer.deposit_received(deale)
          # when ['deposit outstanding', 'deposit received', 'moved in', 'moved out']

          end
        end
      end
      deal.update(state: state) unless state == 'Google Bewertung abgeben'
    rescue Exception => ex
      render :json => {:status => 400, :error => "Webhook failed"} and return
    end
    render :json => {:status => 200}
  end

  private

  def find_correct_state(current_stage)
    res = RestClient.get pipedrive_api_url("stages/#{current_stage}")
    repos = JSON.parse(res)

    stage_name = repos['data']['name']

    state = ''
    case(stage_name)
    when 'Info Mail raus'
      state = 'info mail send'
    when '2. Call'
      state = '2. Call'
    when '3. Call'
      state = '3. Call'
    when 'Warten auf Kundenrückmeldung'
      state = 'wait for customer response'
    when 'Einladung zum Buchungsprozess gesendet'
      state = 'invite send'
    when 'Deposit ausstehend'
      state = 'deposit outstanding'
    when 'Deposit eingegangen'
      state = 'deposit received'
    when 'Eingezogen'
      state = 'moved in'
    when 'Deposit zurücksenden'
      state = 'moved out'
    when 'Google Bewertung abgeben'
      state = stage_name
    end
    return state
  end

  def pipedrive_api_url(action)
    "https://api.pipedrive.com/v1/#{action}?api_token=#{ENV['PIPEDRIVE_API_TOKEN']}"
  end
end
