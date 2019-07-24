class User < ApplicationRecord
  validates :first_name, :last_name, :email, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, presence: true
  mount_uploader :photo, PhotoUploader
  has_many :bookings
  has_many :rooms, through: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :invitable, invite_for: 3.days
end
