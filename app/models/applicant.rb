class Applicant < ApplicationRecord
  # after_create :send_welcome_email
  validates :first_name, :last_name, :email, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, presence: true
end
