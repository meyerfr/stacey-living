class Api::V1::AmenitiesController < ActionController::Base
	def index
		type = params[:type]
		id = params[:type_id]
		case type
		when 'project'
      project = Project.find(id)
			amenities = project.amenities
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
      project = Project.find(id)
			amenities = Project.find(id).community_areas.first.amenities
		when 'roomtype_show'
			roomtype = Roomtype.find(id)
      project = roomtype.project
			amenities = Amenity.joins(:join_amenities).where(join_amenities: {amenitiable_type: 'Roomtype', amenitiable_id: roomtype.id, name: 'roomtype show'})
		end

		unless type == 'roomtype'
			amenities = amenities.map { |amenity|
        title = amenity.title
        case title
        when 'common space'
          title = "#{project.community_areas.first.size.to_i} m2 #{title}"
        when 'fully equipped kitchen'
          if project.name == 'Mühlenkamp'
            title = "2x #{title}s"
          end
        when 'members'
          title = "#{project.rooms.count} #{title}"
        when 'apartments'
          apartment_count = project.rooms.collect(&:apartment_number).uniq.count
          title = "#{apartment_count} #{apartment_count == 1 ? 'apartment' : title}"
        when 'bathrooms'
          bathroom_count = project.rooms.collect(&:apartment_number).uniq.count
          case project.name
          when 'Mühlenkamp'
            bathroom_count += 3
          when 'Eppendorf'
            bathroom_count += 2
          when 'St. Pauli'
            bathroom_count += 1
          end
          title = "#{bathroom_count} #{title}"
        end
	      amenity.as_json.merge({ title: title, photo: url_for(amenity.photo) })
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
