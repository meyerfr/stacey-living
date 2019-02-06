class DeviseUserMailer < Devise::Mailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  helper :application
  default template_path: 'devise/mailer'
  layout 'mailer'
  add_template_helper EmailHelper
  add_template_helper ApplicationHelper

  def invitation_instructions(record, token, opts={})
    super
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Stacey')
  end
end
