class User < ApplicationRecord
  attr_accessor :skip_password_validation, :name, :bookings_attributes # virtual attribute to skip password validation while saving
  # validate :validate_array
  # validate :stay_duration
  # validate :move_in_future
  # validate :validate_prefered_suite
  # validate :validate_gender
  validates :first_name, :last_name, :email, :dob, :phone_number, :job, :amount_of_people, presence: true

  has_many :rooms, through: :bookings
  has_many :welcome_calls
  has_many :bookings, index_errors: true, dependent: :destroy
  accepts_nested_attributes_for :bookings, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def move_in_future
    move_in_helper_array = bookings_attributes['0'].values.first(3).map! { |e| e.to_i }.reverse
    move_in = Date.new(move_in_helper_array[0], move_in_helper_array[1], move_in_helper_array[2])
    if move_in >= Date.today
      true
    else
      errors.add(:bookings_attributes, 'Can´t choose a date in the past.')
    end
  end

  def stay_duration
    move_in_helper_array = bookings_attributes['0'].values.first(3).map! { |e| e.to_i }.reverse
    move_in = Date.new(move_in_helper_array[0], move_in_helper_array[1], move_in_helper_array[2])
    move_out_helper_array = bookings_attributes['0'].values.last(3).map! { |e| e.to_i }.reverse
    move_out = Date.new(move_out_helper_array[0], move_out_helper_array[1], move_out_helper_array[2])
    duration = (move_out.year - move_in.year) * 12 + move_out.month - move_in.month - (move_out.day >= move_in.day ? 0 : 1)
    if duration >= 3
      true
    else
      errors.add(:bookings_attributes, '3 Month minimum')
    end
  end

  def validate_array
    errors.add(:prefered_suite, 'Please choose at least one') if prefered_suite[0] == ""
    errors.add(:gender, 'Please choose') if gender[0] == ""
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

  def superadmin?
    role == 'superadmin'
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end

  def validate_prefered_suite
    errors.add(:prefered_suite) if prefered_suite[0] == ""
  end

  def validate_gender
    errors.add(:gender) if gender[0] == ""
  end
end
