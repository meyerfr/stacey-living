class Api::V2::RoomtypesController < ActionController::Base
  before_action :set_project, :set_roomtypes

  def index
    roomtypes = @roomtypes.sort_by{ |roomtype| roomtype.size }

    roomtypes = roomtypes.map { |roomtype|

      balcony_option = false

      if roomtype.name.include?('(balcony)') || @project.roomtypes.find_by(name: "#{roomtype.name} (balcony)").present?
        balcony_option = true
        this_roomtype_without_balcony = @project.roomtypes.find_by(name: roomtype.name.gsub(' (balcony)', ''))

        this_roomtype_with_balcony = @project.roomtypes.find_by(name: "#{roomtype.name} (balcony)")
      end

      # if roomtype.name.include?('(balcony)') # does this roomtype has a Balcony?
      #   # if yes, look for the roomtype without
      #   this_room_has_balcony = true

      #   this_roomtype_without_balcony = @project.roomtypes.find_by(name: roomtype.name.gsub(' (balcony)', ''))
      # else
      #   # if no, look for the roomtype with balcony
      #   this_roomtype_with_balcony = @project.roomtypes.find_by(name: "#{roomtype.name} (balcony)")
      #   balcony_option = true if this_roomtype_with_balcony.present?
      # end

      if balcony_option
        # if balcony option true, take all attributes from the roomtype without balcony, except: [:availabilities, :prices]
        # balcony attributes includes the id of the roomtype either with or without balcony
        roomtype = roomtype.as_json.merge({
          photos: this_roomtype_without_balcony.photos.map{ |photo|
                    url_for(photo)
                  },
          amenities: {
            roomtype_index_inventory_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inventory'})),
            roomtype_index_inclusion_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inclusion'})),
            roomtype_show_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype show'}))
          },
          # amenities: this_roomtype_without_balcony.amenities,
          description: this_roomtype_without_balcony.descriptions.first,
          prices: roomtype.prices,
          availabilities: roomtype.availabilities,
          balcony: roomtype.name.include?('(balcony)') ? this_roomtype_without_balcony.id : this_roomtype_with_balcony.id
        })
      else
        # if balcony option false, take all attributes from this roomtype
        roomtype = roomtype.as_json.merge({
          photos: roomtype.photos.map{ |photo|
                    url_for(photo)
                  },
          amenities: {
            roomtype_index_inventory_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inventory'})),
            roomtype_index_inclusion_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inclusion'})),
            roomtype_show_amenities: add_photo_to_amenity(Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype show'}))
          },
          description: roomtype.descriptions.first,
          prices: roomtype.prices,
          availabilities: roomtype.availabilities
        })
      end
      roomtype
    }

    render json: roomtypes
    # bookings = @bookings.map { |booking|
    #   room = booking.room
    #   roomtype = room.roomtype
    #   user = booking.user
    #   booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
    # }
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_roomtypes
    # show_categories = ['Mighty', 'Mighty+', 'Premium', 'Premium+', 'Jumbo']
    # @roomtypes = Roomtype.joins(:project).where(name: show_categories, projects: { id: @project.id })
    @roomtypes = @project.roomtypes
  end

  def add_photo_to_amenity(amenities)
    amenities = amenities.map{ |amenity|
      amenity.photo.attached? && amenity.as_json.merge({ photo: url_for(amenity.photo)} )
    }
    return amenities
  end
end
