class Room < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  after_create :create_stripe_product_and_plan
  has_many_attached :photos
  belongs_to :project
  has_many :users, through: :bookings
  has_many :room_attributes, dependent: :destroy
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities
  accepts_nested_attributes_for :room_amenities, allow_destroy: true, reject_if: proc{ |att| att['amenity_id'].nil? }
  accepts_nested_attributes_for :room_attributes, allow_destroy: true, reject_if: proc{ |att| att['number'].blank? }

  def create_stripe_product_and_plan
    raise
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
        nickname: "#{room.name} Rent for #{text} Months",
        currency: "eur"
      )
    end
    self.update(stripe_product: product.id)
  end
end
