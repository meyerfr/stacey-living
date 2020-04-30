class User < ApplicationRecord
  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving
  before_save :clean_up_data

  validate :validate_arrays
  validates :first_name, :last_name, :email, :dob, :phone_number, :job, presence: true

  has_many :rooms, through: :bookings
  has_many :welcome_calls
  has_many :bookings, dependent: :destroy
  has_many :contracts, through: :bookings
  accepts_nested_attributes_for :bookings, allow_destroy: true
  validates_associated :bookings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def clean_up_data
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
    self.email = self.email.downcase
    self.gender = self.gender.pop(1) if self.gender[0] == ''
    self.prefered_suite = self.prefered_suite.pop(1) if self.prefered_suite[0] == ''
  end

  def validate_arrays
    unless role == 'admin'
      errors.add(:prefered_suite, 'Please choose at least one') if prefered_suite.length == 1
      errors.add(:gender, 'Please choose') if gender.length == 1
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def user?
    role == 'user'
  end

  def admin?
    role == 'admin'
  end

  def tenant?
    role == 'tenant'
  end

  def applicant?
    role == 'applicant'
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
