class Api::V1::AmenitiesController < ActionController::Base
	def index
		type = params[:type]
		id = params[:type_id]
		case type
		when 'project'
			amenities = Project.find(id).amenities
		when 'roomtype'
			roomtype = Roomtype.find(id)
			project = roomtype.project
			roomtype_index_inventory_amenities = Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inventory'})
			roomtype_index_inclusion_amenities = Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype index inclusion'})
			# community_area_amenities = Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'CommunityArea', amenitiable_id: project.community_areas.first.id, name: 'roomtype index inclusion'})
			amenities = {
				roomtype_index_inventory_amenities: roomtype_index_inventory_amenities, 
				roomtype_index_inclusion_amenities: roomtype_index_inclusion_amenities
			}
			amenities = amenities.each do |amenity_type, types_amenities|
				types_amenities.map { |amenity|
			      amenity.as_json.merge({ photo: url_for(amenity.photo) })
			    }
			end
		when 'project_show'
			amenities = Project.find(id).community_areas.first.amenities
		when 'roomtype_show'
			roomtype = Roomtype.find(id)
			amenities = Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype show'})
		end

		unless type == 'roomtype'
			amenities = amenities.map { |amenity|
		      amenity.as_json.merge({ photo: url_for(amenity.photo) })
		    }
		end
		render json: amenities
		# bookings = @bookings.map { |booking|
	 #      room = booking.room
	 #      roomtype = room.roomtype
	 #      user = booking.user
	 #      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
	 #    }
	end
end
