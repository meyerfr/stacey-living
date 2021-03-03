class Project < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  cattr_accessor :form_steps do
    %w(project_info address rooms)
  end

  attr_accessor :form_step

  with_options dependent: :destroy do |assoc|
    assoc.has_one :address, as: :addressable, required: false
    assoc.has_many :descriptions, as: :descriptionable
    assoc.has_many :join_amenities, as: :amenitiable
    assoc.has_many :roomtypes
    assoc.has_many :community_areas
  end

  has_many :rooms, through: :roomtypes
  has_many :amenities, through: :join_amenities
  has_many :bookings, through: :rooms
  has_many :prices, through: :roomtypes
  has_many_attached :photos

  accepts_nested_attributes_for :address, :descriptions, :join_amenities, :roomtypes, :community_areas, allow_destroy: true

  # before_save :clean_up_data

  with_options if: -> { required_for_step?(:project_info) } do |step|
    step.validates :name, presence: true
    step.validates_associated :descriptions, :community_areas
    # step.validates_associated :project_amenities
  end

  with_options if: -> { required_for_step?(:address) } do |step|
    step.validates_associated :address
  end

  # with_options if: -> { required_for_step?(:project_amenities) } do |step|
  #   step.validates_associated :project_amenities
  # end

  with_options if: -> { required_for_step?(:rooms) } do |step|
    step.validates_associated :roomtypes
  end

  def active?
    status == 'active'
  end

  def rooms_bookable?
    bookable_rooms = false
    roomtypes.each do |roomtype|
      roomtype.rooms.collect(&:bookable_date).each do |date|
        if date <= Date.today
          bookable_rooms = true
          break
        end
      end
    end
    bookable_rooms
  end

  def cheapest_price
    self.prices.order(:amount).first
  end

  def all_descriptions
    descriptions = self.descriptions
    self.community_areas.each do |community_area|
      descriptions += community_area.descriptions
    end
    descriptions << self.address.description
    return descriptions
  end

  def next_available_move_in_date
    next_available_move_in = Date.today + 10.years
    self.roomtypes.each do |roomtype|
      roomtypes_next_available_move_in = roomtype.next_available_move_in_date
      if roomtypes_next_available_move_in
        next_available_move_in = roomtypes_next_available_move_in if roomtypes_next_available_move_in < next_available_move_in
      end
      if next_available_move_in == Date.tomorrow
        break
      end
    end
    (next_available_move_in != Date.today + 10.years) ? next_available_move_in : false
  end

  def next_available_room
    next_available_move_in = Date.today + 10.years
    next_available_room = nil
    self.rooms.each do |room|
      rooms_next_available_move_in_date = room.next_available_move_in_date
      if rooms_next_available_move_in_date
        if rooms_next_available_move_in_date < next_available_move_in
          next_available_move_in = rooms_next_available_move_in_date
          next_available_room = room
        end
      end
      break if next_available_move_in == Date.tomorrow
    end
    (next_available_move_in != Date.today + 10.years) ? next_available_room : false
  end

  def availabilities
    availabilities = []
    self.roomtypes.each do |roomtype|
      availabilities += roomtype.availabilities
    end
    return availabilities
  end

  # def clean_up_data
  #   self.name = self.name.downcase.titleize
  #   self.street = self.street.downcase.titleize
  #   self.city = self.city.downcase.titleize
  # end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end
