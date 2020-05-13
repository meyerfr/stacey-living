class Roomtype < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  # before_save :create_stripe_product_and_plan
  has_many_attached :photos
  belongs_to :project

  with_options dependent: :destroy do |assoc|
    assoc.has_many :descriptions, as: :descriptionable
    assoc.has_many :room_amenities
    assoc.has_many :rooms
    assoc.has_many :prices
  end

  # has_many :users, through: :bookings
  accepts_nested_attributes_for :room_amenities, allow_destroy: true, reject_if: proc{ |att| att['amenity_id'].nil? }
  accepts_nested_attributes_for :rooms, :prices, :descriptions, allow_destroy: true
  validates_associated :rooms, :prices

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
end
