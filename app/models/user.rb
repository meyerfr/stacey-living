class User < ApplicationRecord
  has_many :bookings
  has_many :invitations, class_name: 'User', as: :invited_by
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :invitable, invite_for: 3.days
end
