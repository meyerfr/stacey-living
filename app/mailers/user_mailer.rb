class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(applicant)
    @applicant = applicant
    mail(to: @applicant.email, subject: 'Stacey - Co-Living')
  end

  def new_applicant_info(applicant)
    @applicant = applicant
    mail(to: 'newapplicant@stacey-living.de', subject: 'New Applicant')
  end
end
