class Roomtype < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  # before_save :create_stripe_product_and_plan
  include Rails.application.routes.url_helpers
  has_many_attached :photos
  belongs_to :project

  with_options dependent: :destroy do |assoc|
    assoc.has_many :descriptions, as: :descriptionable
    # assoc.has_many :room_amenities
    assoc.has_many :join_amenities, as: :amenitiable
    assoc.has_many :rooms
    assoc.has_many :prices
    assoc.has_many :prefered_suites
  end

  has_many :bookings, through: :rooms

  has_many :amenities, through: :join_amenities
  accepts_nested_attributes_for :join_amenities, :rooms, :prices, :descriptions, allow_destroy: true
  validates_associated :rooms, :prices, :join_amenities

  def create_stripe_product_and_plan
    # raise
    product = Stripe::Product.create(
      name: "#{name.capitalize} #{project.name}",
      statement_descriptor: "STACEY Rent",
      type: 'service'
    )
    price.each_with_index do |price, index|
      if index.zero?
        text = '3-5'
      elsif index == 1
        text = '6-8'
      else
        text = '9+'
      end
      Stripe::Plan.create(
        product: product.id,
        amount: price * 100,
        interval: 'month',
        nickname: "#{name} Rent for #{text} Months",
        currency: "eur"
      )
    end
    self.update(stripe_product: product.id)
  end

  def cheapest_price
    self.prices.order(:amount).first.amount
  end

  def next_available_move_in_date
    next_available_move_in = Date.today + 10.years
    self.rooms.each do |room|
      rooms_next_available_move_in_date = room.next_available_move_in_date

      next unless rooms_next_available_move_in_date

      if rooms_next_available_move_in_date && rooms_next_available_move_in_date < next_available_move_in
        next_available_move_in = rooms_next_available_move_in_date
      end

      break if next_available_move_in == Date.tomorrow
    end
    (next_available_move_in != Date.today + 10.years) ? next_available_move_in : false
  end

  def next_available_room
    next_available_move_in = Date.today + 10.years
    next_available_room = nil
    self.rooms.each do |room|
      rooms_next_available_move_in_date = room.next_available_move_in_date

      next unless rooms_next_available_move_in_date

      if rooms_next_available_move_in_date && rooms_next_available_move_in_date < next_available_move_in
        next_available_move_in = rooms_next_available_move_in_date
        next_available_room = room
      end
      break if next_available_move_in == Date.tomorrow
    end
    (next_available_move_in != Date.today + 10.years) ? next_available_room : false
  end

  def availabilities
    availabilities = []
    self.rooms.each do |room|
      rooms_next_available_move_in_date = room.next_available_move_in_date
      next unless rooms_next_available_move_in_date
      availabilities << {room_id: room.id, next_available_move_in_date: rooms_next_available_move_in_date } if rooms_next_available_move_in_date
    end
    return availabilities.uniq{|a| a[:next_available_move_in_date]}.sort_by {|a| a[:next_available_move_in_date]}
  end

  def rooms_bookable?
    bookable_rooms = false
    rooms.collect(&:bookable_date).each do |date|
      if date <= Date.today
        bookable_rooms = true
        break
      end
    end
    bookable_rooms
  end

  def amenities
    amenities = {
      roomtype_index_inventory_amenities: Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: self.id, name: 'roomtype index inventory'}),
      roomtype_index_inclusion_amenities: Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: self.id, name: 'roomtype index inclusion'}),
      roomtype_show_amenities: Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: self.id, name: 'roomtype show'})
    }
    amenities = amenities.each do |amenity_type, types_amenities|
      types_amenities.map { |amenity|
        amenity.as_json.merge({ photo: rails_blob_path(amenity.photo, disposition: "attachment", only_path: true) }) if amenity.photo.attached?
      }
    end
    return amenities
  end
end
