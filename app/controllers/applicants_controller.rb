class ApplicantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @applicants = Applicant.all
  end

  def new
    # @flat = Flat.find(params[:flat_id])
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicants_params)
    if @applicant.save
      #UserMailer.welcome(@applicant).deliver_now
      # later(wait_until: 2.minutes.from_now)
      UserMailer.new_applicant_info(@applicant).deliver_now
    else
      render :new
    end
  end

  def invite
    applicant = Applicant.find(params[:applicant])
    User.invite!({ email: applicant.email, first_name: applicant.first_name, last_name: applicant.last_name })
  end

  private

  def applicants_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone_code, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people)
  end
end
