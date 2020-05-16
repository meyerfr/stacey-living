class User < ApplicationRecord
  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving
  before_save :clean_up_data

  # validate :validate_arrays
  validates :first_name, :last_name, :email, :dob, :phone_number, :gender, :job, presence: true

  with_options dependent: :destroy do |assoc|
    assoc.has_many :welcome_calls
    assoc.has_many :social_links
    assoc.has_many :prefered_suites
    assoc.has_many :bookings
    assoc.has_one :address, as: :addressable, required: false
  end

  with_options through: :bookings do |assoc|
    assoc.has_many :contracts
    assoc.has_many :roomtyes
  end

  accepts_nested_attributes_for :bookings, :social_links, :prefered_suites, :address, allow_destroy: true
  validates_associated :bookings, :social_links, :address, :prefered_suites

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def clean_up_data
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
    self.email = self.email.downcase
    # self.gender = self.gender.pop(1) if self.gender[0] == '' => only necessary if gender would still be array
    # self.prefered_suite = self.prefered_suite.pop(1) if self.prefered_suite[0] == ''
  end

  # def validate_arrays
  #   unless role == 'admin'
  #     errors.add(:prefered_suite, 'Please choose at least one') if prefered_suite.length == 1
  #     errors.add(:gender, 'Please choose') if gender.length == 1
  #   end
  # end

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_role?(role)
    self.role == role
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
