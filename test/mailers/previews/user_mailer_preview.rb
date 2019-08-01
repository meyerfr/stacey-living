# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def waiting_list_mail
    user = User.first
    UserMailer.waiting_list_mail(user)
  end

  def no_basic_suite_mail
    user = User.first
    UserMailer.no_basic_suite_mail(user)
  end

  def new_applicant_info
    user = User.first
    UserMailer.new_applicant_info(user)
  end
end
