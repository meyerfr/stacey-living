class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Stacey - Co-Living')
  end

  def waiting_list_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Stacey - Co-Living')
  end

  def new_applicant_info(user)
    @user = user
    mail(to: 'newapplicant@stacey-living.de', subject: 'New Applicant')
  end

  def contract_mail(user, flat, authentity_token_contract)
    @user = user
    @flat = flat
    @authentity_token_contract = authentity_token_contract
    mail(to: '@user.email', subject: "Stacey - Next Steps to finally move in")
  end
end
