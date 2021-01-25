require 'rest-client'
require 'json'

class Api::V1::WebhooksController < ActionController::Base

  def pipedrive_webhook
    begin
      event = JSON.parse(request.body.read)
      if event['meta']['object'] == 'deal'
        deal_id = event['meta']['id']
        deal = Application.find_by(pipedrive_deal_id: deal_id) || Booking.find_by(pipedrive_deal_id: deal_id)

        current_stage = data.current.stage_id

        state = find_correct_state(current_stage)

        if deal.class == Application && ["2. Call", "3. Call"].include?(state)
          deal.update(state: state)
        elsif deal.class == Booking
          deal.update(state: state)
        end
      end
    rescue Exception => ex
      render :json => {:status => 400, :error => "Webhook failed"} and return
    end
    render :json => {:status => 200}
  end

  private

  def find_correct_state(current_stage)
    res = RestClient.get "https://api.pipedrive.com/v1/stages/11?api_token=cee8402549e6ca794ac2abff6155645b1c3d7b90"
    repos = JSON.parse(res)

    stage_name = repos['data']['name']

    state = ''
    case(current_stage)
    when '2. Call'
      state = '2. Call'
    when '3. Call'
      state = '3. Call'
    when 'Einladung zum Buchungsprozess gesendet'
      state = 'invite send'
    when 'Deposit ausstehend'
      state = 'deposit outstanding'
    when 'Deposit eingegangen'
      state = 'deposit received'
    when 'Eingezogen'
      state = 'moved In'
    when 'Ausgezogen'
      state = 'moved Out'
    end
    return state
  end
end



