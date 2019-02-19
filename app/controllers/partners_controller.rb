class PartnersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find(params[:id])
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partners_params)
    if @partner.save
      # UserMailer.welcome_partner(@partner).deliver_now

      send_partners_info_via_slack(@partner)
      redirect_to "http://www.stacey-living.de"
    else
      render :new
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    redirect_to partners_path
  end

  private

  def partners_params
    params.require(:partner).permit(:name, :email, :phone, :company, :phone_code, :message)
  end

  def send_partners_info_via_slack(partner)
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: '#partners',
      text: "We have a new Partner. At the moment we have #{Partner.count},
      Name: #{partner.name},
      Email: #{partner.email},
      Phone: #{partner.phone_code} #{partner.phone},
      Company: #{partner.company},
      Message: #{partner.message}",
      as_user: true
    )
  end
end
