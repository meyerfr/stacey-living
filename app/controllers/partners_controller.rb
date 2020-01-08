class PartnersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @partners = Partner.all
  end

  def new
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    @partner = Partner.new
  end

  def create
    partner = Partner.new(partners_params)
    if partner.save
      redirect_to partner
    else
      render :new
    end
  end

  def show
    @partner = Partner.find(params[:id])
  end

  private

  def partners_params
    params.require(:partner).permit(
      :name,
      :company,
      :email,
      :phone_code,
      :phone,
      :message
    )
  end
end
