class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :invitable, invite_for: 3.days

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
