class Api::V1::RoomtypesController < ActionController::Base
	def index
		show_categories = ['Mighty', 'Mighty+', 'Premium', 'Premium+', 'Jumbo']
		project = Project.find(params[:project_id])
		roomtypes = project.roomtypes.select{|roomtype| show_categories.include?(roomtype.name)}

		if project.name = 'Eppendorf'
			available_roomtypes = []
			roomtypes.each_with_index do |roomtype, index|
				if roomtype.next_available_room == nil
					roomtype_with_balcony = project.roomtypes.find_by(name: "#{roomtype.name} (balcony)")
					if roomtype_with_balcony.present? && roomtype_with_balcony.next_available_room != nil
						available_roomtypes.push(roomtype_with_balcony)
					else
						available_roomtypes.push(roomtypes)
					end
				else
					available_roomtypes.push(roomtype)
				end
			end
			roomtypes = available_roomtypes
		end

		roomtypes = roomtypes.sort_by {|roomtype| roomtype.size }

		roomtypes = roomtypes.map { |roomtype|
			cheapest_price = roomtype.cheapest_price
			if project.name == 'Eppendorf' && roomtype.name.include?('(balcony)')
				roomtype_without_balcony = project.roomtypes.find_by(name: roomtype.name.gsub(' (balcony)', ''))
				photos = roomtype_without_balcony.photos.map{ |photo|
									 url_for(photo)
								 }
			else
				if roomtype.name == 'Mighty+'
					mighty_roomtype = project.roomtypes.find_by(name: 'Mighty')
					photos = mighty_roomtype.photos.map { |photo|
										 url_for(photo)
									 }
				else
					photos = roomtype.photos.map { |photo|
										 url_for(photo)
									 }
				end
			end
			next_available_move_in = roomtype.next_available_move_in_date
			roomtype_with_balcony_id = project.roomtypes.find_by(name: "#{roomtype.name} (balcony)")&.id
			roomtype.as_json.merge({ cheapest_price: cheapest_price, photos: photos, next_available_move_in: next_available_move_in, roomtype_with_balcony_id: roomtype_with_balcony_id })
		}

		render json: roomtypes
		# bookings = @bookings.map { |booking|
	 #      room = booking.room
	 #      roomtype = room.roomtype
	 #      user = booking.user
	 #      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
	 #    }
	end

	def show
		roomtype = Roomtype.find(params[:id])
		project = roomtype.project
		availabilities = roomtype.availabilities
		if project.name == 'Eppendorf' && roomtype.name.include?('(balcony)')
			roomtype_without_balcony = project.roomtypes.find_by(name: roomtype.name.gsub(' (balcony)', ''))
			roomtype_without_balcony_id = roomtype_without_balcony&.id
			photos = roomtype_without_balcony.photos.map{ |photo|
								 url_for(photo)
							 }
		else
			roomtype_with_balcony_id = project.roomtypes.find_by(name: "#{roomtype.name} (balcony)")&.id
			photos = roomtype.photos.map { |photo|
								 url_for(photo)
							 }
		end
		prices = roomtype.prices.order(amount: :desc).collect(&:amount)

		roomtype = roomtype.as_json.merge({ project: project, photos: photos, availabilities: availabilities, prices: prices, roomtype_with_balcony_id: roomtype_with_balcony_id, roomtype_without_balcony_id: roomtype_without_balcony_id })
		render json: roomtype
	end
end
