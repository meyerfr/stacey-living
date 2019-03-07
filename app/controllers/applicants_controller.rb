class ApplicantsController < ApplicationController
  before_action :authenticate_applicant_for_contract_pages, only: [:contract]
  skip_before_action :authenticate_user!, only: [:new, :create, :success, :contract]

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
      UserMailer.welcome(@applicant).deliver_now
      # later(wait_until: 8.minutes.from_now)
      # UserMailer.new_applicant_info(@applicant).deliver_now
      send_applicants_info_via_slack(@applicant)
      redirect_to applicants_success_path
    else
      render :new
    end
  end

  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy
    redirect_to applicants_path
  end

  def send_invitation_for_contract_pages
    @applicant = Applicant.first
    @authentity_token_contract = Devise.friendly_token
    @expiration_date = Date.today
    @applicant.update!(authentity_token_contract: @authentity_token_contract, authentity_token_contract_expiration: @expiration_date)
    UserMailer.contract_mail(@applicant, @authentity_token_contract).deliver_now
    redirect_to applicants_path
  end

  def contract
    @applicant = Applicant.first
  end

  private

  def applicants_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone_code, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, :linked_in, :instagram, :facebook, :twitter)
  end

  def authenticate_applicant_for_contract_pages
    applicant = Applicant.find(params[:id])
    if applicant.authentity_token_contract == params[:authentity_token_contract]
      if !applicant.authentity_token_contract_expiration.future?
        flash[:alert] = "Please sign in first"
        redirect_to new_applicant_path
      end
    else
      flash[:alert] = "Your not allowed to access this page"
      redirect_to new_applicant_path
    end
  end

  def send_applicants_info_via_slack(applicant)
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: '#applicants',
      text: "We have a new Applicant. At the moment we have #{Applicant.count},
      Name: #{applicant.first_name} #{applicant.last_name},
      Email: #{applicant.email},
      Phone: #{applicant.phone_code} #{applicant.phone},
      Geburtstag: #{applicant.date_of_birth},
      Job: #{applicant.job},
      Einzugsdatum: #{applicant.move_in_date},
      Zeitraum: #{applicant.duration_of_stay},
      Anzahl an Leuten: #{applicant.amount_of_people}",
      as_user: true
    )
  end
end
