class User < ApplicationRecord
  attr_accessor :move_in_date, :duration_of_stay
  validate do
    duration
  end
  validates :first_name, :last_name, :email, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people, presence: true
  mount_uploader :photo, PhotoUploader
  has_many :bookings
  has_many :rooms, through: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :invitable, invite_for: 3.days

  def duration
    move_in = Date.new(move_in_date[1], move_in_date[2], move_in_date[3])
    move_out = Date.new(duration_of_stay[1], duration_of_stay[2], duration_of_stay[3])
    duration = (move_out.year - move_in.year) * 12 + move_out.month - move_in.month - (move_out.day >= move_in.day ? 0 : 1)
    if duration >= 3
      true
    else
      errors.add(:duration_of_stay, 'The minimum membership duration is 3 months')
    end
  end
end
