class ApplicantsController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    # @flat = Flat.find(params[:flat_id])
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicants_params)
    if @applicant.save
      redirect_to "http://www.stacey-living.de"
    else
      render :new
    end
  end

  private

  def applicants_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone_code, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people)
  end
end
