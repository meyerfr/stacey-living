class User < ApplicationRecord
  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving
  before_save :clean_up_data

  GENDER_TYPES = ["Male", "Female"]

  # validate :validate_arrays
  # validates :first_name, :last_name, :email, :dob, :phone_number, presence: true
  # validate :minimum_prefered_suites

  with_options dependent: :destroy do |assoc|
    assoc.has_many :social_links
    assoc.has_many :prefered_suites
    assoc.has_many :bookings
    assoc.has_one :application
    assoc.has_one :address, as: :addressable, required: false
  end

  with_options through: :bookings do |assoc|
    assoc.has_many :contracts, through: :bookings
    assoc.has_many :roomtyes
  end

  accepts_nested_attributes_for :social_links, :prefered_suites, :address, allow_destroy: true
  validates_associated :social_links, :address, :prefered_suites

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def self.to_csv_test
    attributes = %w{email first_name last_name full_phone_number}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def clean_up_data
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
    self.email = self.email.downcase
  end

  def minimum_prefered_suites
    unless self.prefered_suites.length >= 1
      errors.add(:prefered_suites, 'Please choose at least one')
    end
  end

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

  def full_phone_number
    "#{phone_code} #{phone_number}"
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
