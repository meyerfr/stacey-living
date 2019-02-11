# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    applicant = Applicant.first
    UserMailer.welcome(applicant)
  end

  def new_applicant_info
    applicant = Applicant.first
    UserMailer.new_applicant_info(applicant)
  end
end
