require "open-uri"

def create_prices(project_roomtypes_prices_hash)
  project_roomtypes_prices_hash.each do |roomtype, prices|
    prices.each do |duration, amount|
      roomtype.prices.create!(duration: duration, amount: amount)
    end
  end
end

def create_rooms(project_roomtypes_rooms_info)
  project_roomtypes_rooms_info.each do |roomtype, room|
    room.each do |intern_number, house_number|
      roomtype.rooms.create!(intern_number: intern_number, house_number: house_number)
    end
  end
end

def attach_photos(photos_hash)
  photos_hash.each do |object, file_list|
    file_list.each_with_index do |file, idx|
      object.photos.attach(io: file, filename: 'asdgasdg', content_type: 'image/jpg')
      object.save
    end
  end
end

def create_descriptions(description_hash)
  description_hash.each do |object, description_content|
    object.descriptions.create!(field: "#{object.name} description", content: description_content)
  end
end


# new Seed File for project step logic
puts('create Mühlenkamp Project')
muehlenkamp = Project.create!(name: 'Mühlenkamp')

puts('create Mühlenkamp description')
muehlenkamp.descriptions.create!(field: 'project info index', content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in Mühlenkamp is just as energetic as the neighborhood.')
muehlenkamp.descriptions.create!(field: 'project info show', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Mühlenkamp location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!")

puts('create Mühlenkamp Address')
muehlenkamp_address = muehlenkamp.create_address!(street: 'Dorotheenstraße', number: '3', city: 'Hamburg', zip: '22301', country: 'Germany')
puts('create Mühlenkamp Address description')
muehlenkamp_address.create_description!(field: 'address info', content: 'Our first location is located in one of the most liveable districts in Hamburg. What can you expect? Restaurants, bars and  cafes in front of your doorstep. It is your decision whether to spend a warm summer day at the Alster or meet with your roommates in our community spaces for a cold beer after work.')

puts('create Mühlenkamp Community Area')
muehlenkamp_community_area = muehlenkamp.community_areas.create!(name: "common space #{muehlenkamp.name}", size: 100)
puts('create Mühlenkamp Community Area description')
muehlenkamp_community_area.descriptions.create!(field: 'common space description', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Mühlenkamp location can give you all this and more.\nOur 100m2 of community space at ground level comes with:")

puts('create Mühlenkamp Roomtypes')
mighty = muehlenkamp.roomtypes.create!(name: 'Mighty', size: 8)

premium = muehlenkamp.roomtypes.create!(name: 'Premium', size: 13)

premium_plus = muehlenkamp.roomtypes.create!(name: 'Premium+', size: 15)

jumbo = muehlenkamp.roomtypes.create!(name: 'Jumbo', size: 25)

muehlenkamp_photos = {
  muehlenkamp_community_area => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776599/Muehlenkamp/muehlenkamp_com_area_1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776593/Muehlenkamp/muehlenkamp_com_area_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776588/Muehlenkamp/muehlenkamp_com_area_3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776584/Muehlenkamp/muehlenkamp_com_area_4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776587/Muehlenkamp/muehlenkamp_com_area_5.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776617/Muehlenkamp/muehlenkamp_com_area_6.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776604/Muehlenkamp/muehlenkamp_com_area_7.jpg')
  ],
  mighty => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776615/Muehlenkamp/muehlenkamp_mighty_1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776586/Muehlenkamp/muehlenkamp_mighty_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776593/Muehlenkamp/muehlenkamp_mighty_3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776597/Muehlenkamp/muehlenkamp_mighty_4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776588/Muehlenkamp/muehlenkamp_bath.jpg')
  ],
  premium => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776586/Muehlenkamp/muehlenkamp_premium_1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776624/Muehlenkamp/muehlenkamp_premium_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776588/Muehlenkamp/muehlenkamp_bath.jpg')
  ],
  premium_plus => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776585/Muehlenkamp/muehlenkamp_premium_plus_1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776609/Muehlenkamp/muehlenkamp_premium_plus_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776606/Muehlenkamp/muehlenkamp_premium_plus_3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776601/Muehlenkamp/muehlenkamp_premium_plus_4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776588/Muehlenkamp/muehlenkamp_bath.jpg')
  ],
  jumbo => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776592/Muehlenkamp/muehlenkamp_jumbo_1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776599/Muehlenkamp/muehlenkamp_jumbo_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776595/Muehlenkamp/muehlenkamp_jumbo_3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776602/Muehlenkamp/muehlenkamp_jumbo_4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776618/Muehlenkamp/muehlenkamp_jumbo_5.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776584/Muehlenkamp/muehlenkamp_jumbo_6.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776595/Muehlenkamp/muehlenkamp_jumbo_7.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776613/Muehlenkamp/muehlenkamp_jumbo_8.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776610/Muehlenkamp/muehlenkamp_jumbo_9.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776592/Muehlenkamp/muehlenkamp_jumbo_10.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776590/Muehlenkamp/muehlenkamp_jumbo_11.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776588/Muehlenkamp/muehlenkamp_bath.jpg')
  ]
}

puts('attach photos to muehlenkamp roomtypes and community area')
attach_photos(muehlenkamp_photos)

room_descriptions = {
  mighty => "Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.",
  premium => "Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  premium_plus => "Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  jumbo => "Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m2 designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding."
}

puts('create muehlenkamp roomtypes descriptions')
create_descriptions(room_descriptions)

muehlenkamp_roomtypes_prices = {
  mighty => {'3-5 Months': 745, '6-8 Months': 695, '9+ Months': 645},
  premium => {'3-5 Months': 845, '6-8 Months': 795, '9+ Months': 745},
  premium_plus => {'3-5 Months': 895, '6-8 Months': 845, '9+ Months': 795},
  jumbo => {'3-5 Months': 1045, '6-8 Months': 995, '9+ Months': 945}
}

create_prices(muehlenkamp_roomtypes_prices)

muehlenkamp_roomtypes_rooms_info = {
  mighty => {
    "D05" => "D3b 1.OG rechts",
    "D07" => "D3b 2.OG rechts",
    "D09" => "D3b 2.OG links",
    "D10" => "D3 EG links",
    "D11" => "D3 EG links",
    "D13" => "D3 EG rechts",
    "D14" => "D3 EG rechts",
    "D16" => "D5 1.OG rechts",
    "D19" => "D5 2.OG links",
    "D22" => "D3 2.OG links",
    "D25" => "D5 EG links",
    "D27" => "D5 EG links",
    "D28" => "D5 EG links",
    "D29" => "D5a 1.OG rechts",
    "D30" => "D5a 1.OG rechts",
    "D32" => "D5a 2.OG rechts",
    "D33" => "D5a 2.OG rechts",
    "D35" => "D5a 2.OG links",
    "D38" => "D3a 1.OG rechts",
    "D39" => "D3a EG links",
    "D40" => "D3a EG links",
    "D42" => "D3a 1.OG links",
    "D43" => "D3a 1.OG links",
    "D46" => "D3c 1.OG links",
    "D48" => "D3b 1.OG links",
    "D50" => "D3c EG rechts",
    "D52" => "D5a EG rechts",
    "D53" => "D5a EG rechts"
  },
  premium => {
    "D01" => "D3d 2.OG",
    "D02" => "D3d 2.OG",
    "D03" => "D3d 2.OG",
    "D17" => "D5 1.OG rechts",
    "D20" => "D5 2.OG links",
    "D23" => "D3 2.OG links",
    "D51" => "D5a EG rechts"
  },
  premium_plus => {
    "D12" => "D3 EG links",
    "D15" => "D3 EG rechts",
    "D18" => "D5 1.OG rechts",
    "D21" => "D5 2.OG links",
    "D24" => "D3 2.OG links",
    "D26" => "D5 EG links",
    "D31" => "D5a 1.OG rechts",
    "D34" => "D5a 2.OG rechts",
    "D41" => "D3a EG links",
    "D44" => "D3a 1.OG links"
  },
  jumbo => {
    "D04" => "D3b 1.OG rechts",
    "D06" => "D3b 2.OG rechts",
    "D08" => "D3b 2.OG links",
    "D36" => "D5a 2.OG links",
    "D37" => "D3a 1.OG rechts",
    "D45" => "D3c 1.OG links",
    "D47" => "D3b 1.OG links",
    "D49" => "D3c EG rechts"
  }
}

create_rooms(muehlenkamp_roomtypes_rooms_info)

# create Amenities new Photos to do so.
amenities = {
  "wifi" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/wifi.png'),
  "smart locks" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/padlock.png'),
  "coffee flatrate" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/coffee-cup.png'),
  "fully furnished" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/couch.png'),
  "work spaces" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/work-space.png'),
  "table tennis" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/ping-pong.png'),
  "common space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/meeting.png'),
  "weekly cleaning" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/liquid-soap.png'),
  "fully equipped kitchen" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/chefs-hat.png'),
  "2x fully equipped kitchens" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/chefs-hat.png'),
  "lounge space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/lounge-chair.png'),
  "inner yard" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/tree.png'),
  "2 people" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/users.png'),
  "dining space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/service.png'),
  "laundry room" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/washing-machine.png'),
  "1 person" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/user.png'),
  "monthly member events" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/calendar.png'),
  "welcome gift" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/gift.png'),
  "side table" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/side-table.png'),
  "wardrobe with hangers and drawers" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/closet.png'),
  "artwork" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/artist.png'),
  "armchair" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608024/armchair.png'),
  "desk with chair" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/desk.png'),
  "bedding" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/pillow.png'),
  "double bed" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608024/bed.png'),
  "king size bed" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608608/king_size_bed.png')
}

def handle_string_io_as_file(io)
  return io unless io.class == StringIO

  file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
  file.binmode
  file.write io.read
  file.open
end

amenities.each do |title, file|
  a = Amenity.new(title: title)
  a.photo.attach(io: handle_string_io_as_file(file), filename: "#{title.gsub(' ', '_')}.png", content_type: 'image/png')
  a.save
end

# print('update Amenities')

# Amenity.destroy_all

# Amenity.create(icon_text: "<i class=\"fas fa-wifi\"></i>", title: "internet", type: 'includes')
# Amenity.create(icon_text: "<i class=\"fas fa-couch\"></i>", title: "fully furnished")
# Amenity.create(icon_text: "<i class=\"fas fa-tv\"></i>", title: "Netflix")
# Amenity.create(icon_text: "<i class=\"fas fa-briefcase\"></i>", title: "work spaces")
# Amenity.create(icon_text: "<i class=\"fas fa-table-tennis\"></i>", title: "table tennis")
# Amenity.create(icon_text: "<i class=\"fas fa-utensils\"></i>", title: "fully equiped kitchen")
# Amenity.create(icon_text: "<i class=\"fas fa-utensils\"></i>", title: "2x fully equiped kitchen")
# Amenity.create(icon_text: "<i class=\"fas fa-lock-open\"></i>", title: "smart locks")
# Amenity.create(icon_text: "<i class=\"fas fa-broom\"></i>", title: "weekly cleaning", type: 'includes')
# Amenity.create(icon_text: "<i class=\"fas fa-bed\"></i>", title: "queen size bed", type: 'inventory')
# Amenity.create(icon_text: "<i class=\"fas fa-user\"></i>", title: "For 1 member")
# Amenity.create(icon_text: "<i class=\"fas fa-user-friends\"></i>", title: "For up to 2 members")
# Amenity.create(title: "Double Bed", type: 'inventory')
# Amenity.create(title: "wardrobe with hangers & drawers", type: 'inventory')
# Amenity.create(title: "armchair", type: 'inventory')
# Amenity.create(title: "desk with chair", type: 'inventory')
# Amenity.create(title: "side table", type: 'inventory')
# Amenity.create(title: "bedding", type: 'inventory')
# Amenity.create(title: "artwork", type: 'inventory')
# Amenity.create(title: "welcome present", type: 'inventory')
# Amenity.create(title: "Your private suite", type: 'includes')
# Amenity.create(title: "access to the community spaces", type: 'includes')
# Amenity.create(title: "utilities", type: 'includes')
# Amenity.create(icon_text: '<i class="fas fa-mug-hot"></i>', title: "coffee- & water flat rate", type: 'includes')
# Amenity.create(title: "basic supplies", type: 'includes')
# Amenity.create(title: "monthly member events", type: 'includes')

# print('update Database to current situation');
# print('create first Project')
# first_project = Project.create(
#   street: "Dorotheenstraße",
#   house_number: "3-5",
#   city: "Hamburg",
#   zipcode: 22301,
#   name: "Mühlenkamp",
#   description:
#   "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\\r\\nFrom the great living room and the shared kitchen to our beautiful terrace with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!",
#   pictures:
#   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4061_location_muehlenkamp.jpg",
#    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4077_location_muehlenkamp.jpg",
#    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4068_location_muehlenkamp.jpg"]
# )

# print("create All Rooms for #{first_project.name}")
# print('create all Mighty Suites');
# description = 'Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.'
# price = [795.0, 745.0, 695.0]
# name = 'Mighty'
# size = 8.0
# house_number = '5'

# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'renenavrkal@gmail.com').id, room_id: Room.last.id, move_in: '2019-08-31', move_out: '2020-02-30', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'candidodomingocastillo@gmail.com').id, room_id: Room.last.id, move_in: '2019-10-04', move_out: '2020-05-03', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'candidodomingocastillo@gmail.com').id, room_id: Room.last.id, move_in: '2019-10-04', move_out: '2020-05-03', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'anastasia.krieg@t-online.de').id, room_id: Room.last.id, move_in: '2020-02-02', move_out: '2020-05-01', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'kyleyrosser99@gmail.com').id, room_id: Room.last.id, move_in: '2019-10-07', move_out: '2020-03-28', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'pierre.guillaume@audencia.com').id, room_id: Room.last.id, move_in: '2020-01-06', move_out: '2020-05-16', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'nbiosca2q@gmail.com').id, room_id: Room.last.id, move_in: '2019-11-06', move_out: '2020-03-31', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)

# print('create all Premium Suites');
# description = 'Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.'
# price = [945.0, 895.0, 845.0]
# name = 'Premium'
# size = 13.0
# house_number = '5'

# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'andrea.cianfarani@hotmail.com').id, room_id: Room.last.id, move_in: '2019-10-04', move_out: '2020-04-03', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'joachim.bizot@outlook.fr').id, room_id: Room.last.id, move_in: '2020-01-07', move_out: '2020-07-06', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'angeloarceri@live.it').id, room_id: Room.last.id, move_in: '2019-10-03', move_out: '2020-04-02', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)

# print('create all Premium Plus Suites');
# description = 'Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.'
# price = [995.0, 945.0, 895.0]
# name = 'Premium Plus'
# size = 15.0
# house_number = '5'

# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'clacoleu@aol.com').id, room_id: Room.last.id, move_in: '2019-08-05', move_out: '2020-03-05', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'gino.lodola@hotmail.com').id, room_id: Room.last.id, move_in: '2019-12-30', move_out: '2020-03-29', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'miss.kroeger@web.de').id, room_id: Room.last.id, move_in: '2020-01-04', move_out: '2020-05-01', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'david.hoehl@aol.com').id, room_id: Room.last.id, move_in: '2019-11-04', move_out: '2020-05-03', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'vbracamontes.bss@gmail.com').id, room_id: Room.last.id, move_in: '2019-11-04', move_out: '2020-04-03', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)

# print('create all Jumbo Suites');
# description = 'Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m<sup>2</sup> designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding.'
# price = [1095.0, 1045.0, 995.0]
# name = 'Jumbo'
# size = 25.0
# house_number = '5'

# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'schaub.melanie@gmail.com').id, room_id: Room.last.id, move_in: '2019-07-29', move_out: '2021-01-27', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'ch.ritterbach@t-online.de').id, room_id: Room.last.id, move_in: '2019-12-01', move_out: '2020-05-31', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)
# Booking.create(user_id: User.find_by(email: 'jn.f.mueller@gmail.com').id, room_id: Room.last.id, move_in: '2019-09-01', move_out: '2020-02-29', state: 'booked')
# Room.create(project_id: Project.first.id, price: price, description: description, name: name, size: size, house_number: house_number)

# Project.create(
#   street: "Eppendorfer Weg",
#   house_number: "270/270a",
#   city: "Hamburg",
#   zipcode: 20251,
#   name: "Eppendorf",
#   description:
#   "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\\r\\nFrom the great living room and the shared kitchen to our beautiful terrace with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!",
#   pictures:
#   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4061_location_muehlenkamp.jpg",
#    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4077_location_muehlenkamp.jpg",
#    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4068_location_muehlenkamp.jpg"]
# )


# print('add Amenities to Rooms')
# Room.all.each do |room|
#   Amenity.all.each{ |amenity| RoomAmenity.create(amenity_id: amenity.id, room_id: room.id)}
# end

# Project.all.each do |project|
#   Amenity.all.each{ |amenity| ProjectAmenity.create(amenity_id: amenity.id, project_id: project.id)}
# end

# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# # #
# # # Examples:
# # #
# # #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# # #   Character.create(name: 'Luke', movie: movies.first)

# # print('create Admins')
# # fritz = User.create(first_name: 'Fritz', last_name: 'Meyer', email: 'fritz@stacey-living.de', password: 'FritzMeyer', role: 'Admin', dob: '2000-04-02', job: 'Developer', gender: ['Male'], phone_code: '+49', phone_number: '01737557722', prefered_suite: ['Mighty'])
# # matteo = User.create!(first_name: 'Matteo', last_name: 'Kreidler', email: 'matteo@stacey-living.de', password: 'MatteoKreidler', role: 'Admin', dob: '1996-08-26', job: 'CEO', gender: ['Male'], phone_code: '+49', phone_number: '015234514111', prefered_suite: ['Mighty'])
# # anna = User.create!(first_name: 'Anna', last_name: 'Weirauch', email: 'hello@stacey-living.de', password: 'AnnaWeirauch', role: 'Admin', dob: '1999-03-01', job: 'Community Manager', gender: ['Female'], phone_code: '+49', phone_number: '01784309464', prefered_suite: ['Mighty'])

# # # print('create Bookings')
# # # fritz_booking = Booking.create(user_id: fritz.id, move_in: Date.tomorrow, move_out: Date.tomorrow + 3.months)
# # # matteo_booking = Booking.create(user_id: matteo.id, move_in: Date.tomorrow, move_out: Date.tomorrow + 3.months)

# # # print('create WelcomeCalls')
# # # WelcomeCall.create(start_time: Time.parse('2020-01-09 5:30pm'), end_time: Time.parse('2020-01-09 5:45pm'), available: false, booking_id: fritz_booking)
# # # WelcomeCall.create(start_time: Time.parse('2020-01-09 5:00pm'), end_time: Time.parse('2020-01-09 5:15pm'), available: false, booking_id: matteo_booking)

# # print('create Project')
# # muehlenkamp = Project.create(
# #   street: "Dorotheen Straße",
# #   house_number: "5-7",
# #   city: "Hamburg",
# #   zipcode: 12345,
# #   name: "Mühlenkamp",
# #   description: "At  STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\\r\\nFrom the great living room and the shared kitchen to our beautiful terrace with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!", pictures:["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4061_location_muehlenkamp.jpg", "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4077_location_muehlenkamp.jpg", "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4068_location_muehlenkamp.jpg"]
# # )

# # print("create Mühlenkamp rooms")
# # mighty = Room.create(
# #  project_id: muehlenkamp.id,
# #  number: "1",
# #  house_number: "5",
# #  price: [900.0, 850.0, 800.0],
# #  name: "Mighty",
# #  size: 15.5,
# #  description: "Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.",
# #  pictures:
# #   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg"]
# # )

# # premium = Room.create(
# #  project_id: muehlenkamp.id,
# #  number: "1",
# #  house_number: "5",
# #  price: [950.0, 900.0, 850.0],
# #  name: "Premium",
# #  size: 15.5,
# #  description: "Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
# #  pictures:
# #   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg"]
# # )

# # premium_plus = Room.create(
# #  project_id: muehlenkamp.id,
# #  number: "1",
# #  house_number: "5",
# #  price: [950.0, 900.0, 850.0],
# #  name: "Premium Plus",
# #  size: 15.5,
# #  description: "Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
# #  pictures:
# #   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg"]
# # )

# # jumbo = Room.create(
# #  project_id: muehlenkamp.id,
# #  number: "1",
# #  house_number: "5",
# #  price: [1000.0, 950.0, 900.0],
# #  name: "Jumbo",
# #  size: 15.5,
# #  description: "Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m<sup>2</sup> designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding.",
# #  pictures:
# #   ["https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg",
# #    "https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg"]
# # )

# # print('create Amenities')
# # wifi = Amenity.create(title: 'High Speed Wifi', icon_text: '<i class="fas fa-wifi"></i>')
# # speakers = Amenity.create(title: 'Speakers', icon_text: '<i class="fas fa-volume-up"></i>')
# # furnished = Amenity.create(title: 'Furnished', icon_text: '<i class="fas fa-couch"></i>')
# # netflix = Amenity.create(title: 'Netflix', icon_text: '<i class="fas fa-tv"></i>')
# # work_space = Amenity.create(title: 'Work Spaces', icon_text: '<i class="fas fa-briefcase"></i>')
# # tabletennis = Amenity.create(title: 'Tabletennis', icon_text: '<i class="fas fa-table-tennis"></i>')
# # communal_kitchen = Amenity.create(title: 'Communal Kitchen', icon_text: '<i class="fas fa-utensils"></i>')
# # smart_lock = Amenity.create(title: 'Smart Lock', icon_text: '<i class="fas fa-lock-open"></i>')
# # weekly_cleaning = Amenity.create(title: 'Weekly Cleaning', icon_text: '<i class="fas fa-broom"></i>')
# # queen_size_bed = Amenity.create(title: 'Queen Size Bed', icon_text: '<i class="fas fa-bed"></i>')
# # one_person = Amenity.create(title: 'One Person', icon_text: '<i class="fas fa-user"></i>')
# # two_people = Amenity.create(title: 'Two People', icon_text: '<i class="fas fa-user-friends"></i>')

# # print('create connection between rooms/projects and amenities')
# # Room.all.each do |room|
# #   Amenity.all.each{ |amenity| RoomAmenity.create(amenity_id: amenity.id, room_id: room.id)}
# # end

# # Project.all.each do |project|
# #   Amenity.all.each{ |amenity| ProjectAmenity.create(amenity_id: amenity.id, project_id: project.id)}
# # end

# # # print('create Rooms')
# # # Room.create(project_id: muehlenkamp.id, number: '1', house_number: '5', price: [900, 850, 800], name: 'Mighty', size: 15.5, description: 'Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.', pictures: ['https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg'])

# # print('create old database users')
# # User.create!(first_name: 'Kristina', last_name: 'Garbe', email: 'kristina.garbe@gmx.de', phone_code: '+49', phone_number: '15146321022', dob: '1981-06-20', job: 'Account Manager', amount_of_people: 'NO', linkedin: 'KristinA Garbe', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Shafigh', last_name: 'Shahbazi', email: 'shafigh@gmx.de', phone_code: '+49', phone_number: '17676643454', dob: '1982-12-30', job: 'Software Entwickler(ich besitze Blaue Karte)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nina', last_name: 'Jakob', email: 'nina.jakob@yahoo.de', phone_code: '+49', phone_number: '151 27084170', dob: '1995-02-08', job: 'Student, Graphic Designer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lea', last_name: 'Bostelmann', email: 'lea.bostelmann@outlook.com', phone_code: '', phone_number: '+4917624519618', dob: '1996-06-06', job: 'Sales Retailer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Dragos', last_name: 'Danaila', email: 'dnldragos@gmail.com', phone_code: '+40', phone_number: '730709886', dob: '1987-12-31', job: 'engineer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sandra', last_name: 'Graszek', email: 'sandragraszek1@gmail.com', phone_code: '+49', phone_number: '017621321821', dob: '1994-03-18', job: 'Pflegefachkraft ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'Sandra Graszek ', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Melissa', last_name: 'Gatkowsky', email: 'melissagatkowsky@freenet.de', phone_code: '+49', phone_number: '15257233105', dob: '1990-07-05', job: 'Hotel operations offiCer', amount_of_people: 'NO', linkedin: '', facebook: 'Melissa gatkowsky', twitter: '', instagram: 'Mel_gatko', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ida', last_name: 'Bratumil', email: 'idabratumil@gmail.com', phone_code: '+47', phone_number: '46946977', dob: '1989-02-24', job: 'User Experience Designer ', amount_of_people: 'NO', linkedin: 'Ida bratumil', facebook: '', twitter: '', instagram: 'idafjellberg', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Joanna', last_name: 'Parassiadis', email: 'joannaparassiadis@gmail.com', phone_code: '+49', phone_number: '1784475031', dob: '1998-07-31', job: 'ArchitEktur', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'joannaparassiadis', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tijender', last_name: 'Singh', email: 'tijendersingh7@icloud.com', phone_code: '+49', phone_number: '15127654780', dob: '1988-12-07', job: 'Job ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Priyanka ', last_name: 'Dayanand ', email: 'priyanka90sunrise@gmail.com', phone_code: '+49', phone_number: '17622251488', dob: '1990-09-08', job: 'Job', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rebecca', last_name: 'Burgau', email: 'r.burgau@gmx.de', phone_code: '+49', phone_number: '17624624829', dob: '1991-12-28', job: 'RechtsreferEndarin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sophie', last_name: 'Rissmann', email: 'sophierissmann@gmx.de', phone_code: '+49', phone_number: '15122498852', dob: '1996-07-03', job: 'Medizinische Fachangestellte ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nadirah', last_name: 'Norruddin', email: 'nadirah.norruddin@gmail.com', phone_code: '+65', phone_number: '81383214', dob: '1991-02-05', job: 'History researcher / STUDENT', amount_of_people: 'NO', linkedin: '', facebook: 'https://www.facebook.com/nadirah.nazaraly', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rashi', last_name: 'Pant', email: 'rashipant@gmail.com', phone_code: '+49', phone_number: '1781686878', dob: '1994-09-19', job: 'Phd researChEr', amount_of_people: 'NO', linkedin: '', facebook: 'Www.Facebook.Com/hellotherestalker19', twitter: '', instagram: '', prefered_suite: ["", "Basic", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Philipp', last_name: 'Maas', email: 'contact@philippmaas.com', phone_code: '+49', phone_number: '1785251960', dob: '1990-01-09', job: 'Freelance Director Animation Visual Effects', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/philipp-maas-8b096049/', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cynthia ', last_name: 'Siergiej', email: 'cynthia_siergiej1997@hotmail.com', phone_code: '+49', phone_number: '017680096120', dob: '1997-06-23', job: 'ErZieherin ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Prabhnoor', last_name: 'Kaur', email: 'prabhnoor.cca@gmail.com', phone_code: '', phone_number: '9592089149', dob: '1998-07-14', job: 'Architecture student', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Artur', last_name: 'Pervyy', email: 'apervyi@gmail.com', phone_code: '+30', phone_number: '6955615468', dob: '1996-05-28', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: 'https://www.facebook.com/arthur.pervyi', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Marie', last_name: 'Dürr', email: 'marie.duerr@t-online.de', phone_code: '+49', phone_number: '17630649008', dob: '2000-01-23', job: 'I`m a student at the Bucerius law school', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ali', last_name: 'Haider', email: 'alibarcha97@hotmail.com', phone_code: '+49', phone_number: '176 26314926', dob: '1997-10-01', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Florian', last_name: 'Steenbock', email: 'flo.steenbock@web.de', phone_code: '+49', phone_number: '1601570740', dob: '1984-06-27', job: 'Controller', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rosalie', last_name: 'Mcdonough', email: 'rosevmcd@gmail.com', phone_code: '+49', phone_number: '17647767053', dob: '1986-11-20', job: 'Doctor', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lennard', last_name: 'Kohn', email: 'lennard@jaoc.de', phone_code: '+49', phone_number: '15786002806', dob: '1996-03-26', job: 'Im a young entrepreneur with my own startup agency & i work for a consulting firm in hamburg & i receive a scholarship (deutschland Stipendium). Also im flexible with the dates for moving in and moving out', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Christopher', last_name: 'Mede', email: 'christopher.mede7@gmail.com', phone_code: '+49', phone_number: '1626825812', dob: '1997-07-23', job: 'VERTRIEBLEr,Vattenfall', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Clemens', last_name: 'Schneider', email: 'clemens-wulfsen@hotmail.de', phone_code: '+49', phone_number: '15170184392', dob: '1994-07-18', job: 'Specilist Apple, Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Melanie', last_name: 'Schaub', email: 'schaub.melanie@gmail.com', phone_code: '+49', phone_number: '17662488480', dob: '1985-07-20', job: 'Asset Manager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lisa', last_name: 'Kürpick', email: 'lisakuerpick@gmail.com', phone_code: '+49', phone_number: '17656507608', dob: '1992-12-04', job: 'HR Service Manager at MOIA Operations gmbh', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/lisa-kuerpick/', facebook: '', twitter: '', instagram: 'Lisa_krpck', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Daniel', last_name: 'Reinold', email: 'daniel@visual-braindump.de', phone_code: '+49', phone_number: '15158714939', dob: '1984-04-29', job: 'Business Visualization and Coaching', amount_of_people: 'NO', linkedin: '', facebook: 'daniel', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lauren', last_name: 'Yun', email: 'laurenmmmg@gmail.com', phone_code: '+49', phone_number: '1634748919', dob: '1989-08-26', job: 'sales assistant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kristof ', last_name: 'Szabo', email: 'szabokb@gmail.com', phone_code: '+49', phone_number: '±4542676307', dob: '1997-07-24', job: 'Entrepreneur', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Clarissa', last_name: 'Leu', email: 'clacoleu@aol.com', phone_code: '+49', phone_number: '1722816850', dob: '1997-07-24', job: 'Teacher/lehrerin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gauriesh', last_name: 'Bindra', email: 'gaurieshbindra@gmail.com', phone_code: '+49', phone_number: '1628519984', dob: '1997-07-22', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sristi', last_name: 'Sen', email: 'sristi.9420.sen@gmail.com', phone_code: '+91', phone_number: '8551012077', dob: '1997-07-24', job: 'Am a StudenT', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tarun', last_name: 'Tahilramani', email: 'taruntahilramani9420@gmail.com', phone_code: '+91', phone_number: '9665154901', dob: '1997-02-20', job: 'I am Student at Ism hamburg ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Aurora', last_name: 'Cimenti', email: 'aurora8991@gmail.com', phone_code: '+65', phone_number: '3458809411', dob: '1998-01-20', job: 'STUDENT', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'RebelheavT', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Hardik', last_name: 'Sharma', email: 'hardik92sharma@gmail.com', phone_code: '+49', phone_number: '1727748195', dob: '1997-07-24', job: 'Student (intern)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Zahra', last_name: 'Izadi', email: 'zahra.izadi@web.de', phone_code: '+49', phone_number: '15733225037', dob: '1996-05-06', job: 'Universität', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sanaz', last_name: 'Atabaki', email: 'sanaz.atabaki@live.de', phone_code: '+49', phone_number: '17635600980', dob: '1985-06-24', job: 'hi, wir haben jetzt vor 2 min telefoniert. vielen dank nochmal für das tolle gespräch. freue mich von dir zu hören. viele grüße', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Baris', last_name: 'Arslan', email: 'arslan.baris@outlook.de', phone_code: '+49', phone_number: '1719791449', dob: '1993-11-14', job: 'IT Consultant/Project Management', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Benjamin kai', last_name: 'Zimmer', email: 'contact.benjamin.kai.zimmer@gmail.com', phone_code: '+49', phone_number: '15115485440', dob: '1993-12-20', job: 'Student, Graduation in 2020', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ingmar', last_name: 'Vocke-neumann', email: 'neumann.ingmar@web.de', phone_code: '+49', phone_number: '17670020686', dob: '1977-02-11', job: 'Stiftungsreferent (NGO) ', amount_of_people: 'NO', linkedin: '', facebook: 'Ingmar Neumann', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leilani', last_name: 'Franco', email: 'francoleilani@gmail.com', phone_code: '+49', phone_number: '15157844356', dob: '1986-04-09', job: 'Creative technologist ', amount_of_people: 'NO', linkedin: 'www.linkedin.com/in/francoleilani', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Justine', last_name: 'Lee', email: 'justine.lee@gmx.de', phone_code: '+49', phone_number: '16095780377', dob: '1994-12-23', job: 'Student + MUM', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sigrid', last_name: 'Streifer', email: 'sigrid.streifer@minbuza.nl', phone_code: '+49', phone_number: '151 65628559', dob: '1997-07-05', job: 'Chief Representative Netherlands Business Support Office Hamburg', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '@SigridStreifer', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sigrid', last_name: 'Streifer', email: 'sigrid.streifer@googlemail.com', phone_code: '+49', phone_number: '151 65628559', dob: '1960-07-26', job: 'Chief Representative Netherlands Business Support Office Hamburg', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '@SigridStreifer', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Carla', last_name: 'Schell', email: 'carlaschell@t-online.de', phone_code: '+49', phone_number: '15123655085', dob: '1998-07-02', job: 'CONSULTING INTERN DELOITTE', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rahul', last_name: 'Banik', email: 'banik.rahul1991@gmail.com', phone_code: '+91', phone_number: '7899077073', dob: '1991-07-17', job: 'Aog desk officer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Annika', last_name: 'Meyer', email: 'annika.pelze@gmail.com', phone_code: '+49', phone_number: '17630418495', dob: '1996-07-12', job: 'Internship ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'Annikmey', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Amalia', last_name: 'Ovín rodríguez', email: 'amalia.ovin@gmail.com', phone_code: '+34', phone_number: '666765425', dob: '1997-12-30', job: 'Fremdsprachenassistentin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sandra', last_name: 'Frehse', email: 'sandrafrehse@aol.com', phone_code: '+49', phone_number: '15208903967', dob: '1997-07-28', job: 'INTERIOR DESIGNER ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Alix', last_name: 'Malicet', email: 'malicetalix08@gmail.com', phone_code: '+33', phone_number: '663172150', dob: '1999-12-17', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'mlct_alix', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lauren', last_name: 'Yun', email: 'yhjmmmg@gmail.com', phone_code: '+49', phone_number: '1634748919', dob: '1997-07-29', job: 'sales assistant ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gregor', last_name: 'Mertgen', email: 'gregormertgen@yahoo.de', phone_code: '+49', phone_number: '15173000770', dob: '1997-02-08', job: 'Student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lukas', last_name: 'Pornschlegel', email: 'lukas.pornschlegel@icloud.com', phone_code: '+49', phone_number: '1703232958', dob: '1996-04-23', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic"], password: 'stacey-living123456789')
# # User.create!(first_name: 'James', last_name: 'Peek', email: 'james.c.peek@gmail.com', phone_code: '+61', phone_number: '422132161', dob: '1992-04-22', job: 'Policy/researcher ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sara', last_name: 'Wegmann', email: 'sara.wegmann@zoho.eu', phone_code: '+49', phone_number: '15779770544', dob: '1985-01-18', job: 'Editorial Trainee', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Carlos', last_name: 'Tello', email: 'carlostellovh@gmail.com', phone_code: '+49', phone_number: '1759951352', dob: '1989-03-15', job: 'Study/work', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Barnabas', last_name: 'Potor', email: 'potorbarnabas@gmail.com', phone_code: '+49', phone_number: '17622838649', dob: '2000-05-24', job: 'student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jana', last_name: 'Sokolinski', email: 'jana.sokolinski@gmail.com', phone_code: '+49', phone_number: '15252069114', dob: '1999-02-08', job: 'duale Studentin', amount_of_people: 'NO', linkedin: '', facebook: 'https://www.facebook.com/profile.php?id=100004828787350', twitter: '', instagram: 'https://www.instagram.com/yaanaaii/', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Bahadir', last_name: 'Öztürk', email: 'oe_b@web.de', phone_code: '+49', phone_number: '17631094772', dob: '1997-07-31', job: 'Ich bin ab 01.08. Beamter bei bezirksamt wandsbek', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Dina', last_name: 'Wahage', email: 'dinawahage@gmail.com', phone_code: '+49', phone_number: '17622017105', dob: '1993-01-21', job: 'Senior BDR but from October TRainee ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rebecca', last_name: 'Stickling', email: 'rebecca.stickling@gmx.de', phone_code: '+49', phone_number: '1639677977', dob: '1995-10-30', job: 'Receptionist at the Renaissance hamburg hotel', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jordan', last_name: 'Mok', email: 'jmok1@sheffield.ac.uk', phone_code: '+49', phone_number: '07543905979', dob: '1999-06-18', job: 'Language assistant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Davide', last_name: 'Fucci', email: 'davfuc@gmail.com', phone_code: '+49', phone_number: '1634006714', dob: '1985-06-16', job: 'University Professor', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Julian', last_name: 'Müller', email: 'jn.f.mueller@gmail.com', phone_code: '+49', phone_number: '15775196869', dob: '1982-07-18', job: 'Researcher, University of Hamburg', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ana', last_name: 'Riethmuller', email: 'anariethmuller@gmail.com', phone_code: '+49', phone_number: '1788057081', dob: '1995-08-30', job: 'Intern', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/ana-riethm%C3%BCller-7500b0a7/', facebook: '', twitter: '', instagram: '@anarieth', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'An', last_name: 'Richter', email: 'andrea_74@gmx.de', phone_code: '+49', phone_number: '05121/1768266', dob: '1997-07-31', job: 'Examinierte Lehrerin [1. + 2. Staatsexamen] - macht gerade eine Weiterbildung/Umschulung etc. ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Miriam', last_name: 'Reimer', email: 'miriam-fahrdorf@web.de', phone_code: '+49', phone_number: '017635366499', dob: '1991-08-26', job: 'Kaufmännische Leitung', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nahede', last_name: 'Hassan', email: 'nahede_@live.de', phone_code: '+49', phone_number: '17634624201', dob: '1994-06-13', job: 'MakeUp Artist & Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leonie', last_name: 'Gerstl', email: 'gerstl.rbl@t-online.de', phone_code: '+49', phone_number: '15142895970', dob: '1999-11-04', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Fabian', last_name: 'Pöschl', email: 'fabian.poe@googlemail.com', phone_code: '+49', phone_number: '1625401872', dob: '1994-10-25', job: 'WIrtschaftsinformatiker', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ernesto', last_name: 'Ruiz manzano', email: 'ernesto_900_ruiz@hotmail.com', phone_code: '+52', phone_number: '4772239170', dob: '1991-11-20', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Angie', last_name: 'Sanchez', email: 'angsanchezf@icloud.com', phone_code: '+49', phone_number: '004915221897578', dob: '1991-07-22', job: 'Marketing manager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Yuchen', last_name: 'Yang', email: 'yangyuchen793@gmail.com', phone_code: '+86', phone_number: '13354051612', dob: '2000-06-13', job: 'student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Daniel', last_name: 'Carvalho', email: 'daniel.carvalho@emle.eu', phone_code: '+49', phone_number: '59397033', dob: '1980-02-20', job: 'civil servant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kai', last_name: 'Kraehmer', email: 'kaikraehmer@gmx.de', phone_code: '+49', phone_number: '17624745174', dob: '1995-09-04', job: 'Graphic Designer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Arkaprabha', last_name: 'Ray', email: 'arkadeep97@gmail.com', phone_code: '+49', phone_number: '1726078047', dob: '1997-06-17', job: 'SUPPLY CHAIN AND PRODUCTION INTERN', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lopa', last_name: 'Roy', email: 'lopa_amit@rediffmail.com', phone_code: '+49', phone_number: '186 2342347', dob: '1997-08-12', job: 'internship', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lopa', last_name: 'Roy', email: 'sharmistharoy1948@gmail.com', phone_code: '+49', phone_number: '186 2342347', dob: '1997-08-12', job: 'internship', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Surya sri charan', last_name: 'Nadupuri', email: 'charannadupuri@gmail.com', phone_code: '+49', phone_number: '1792745655', dob: '1992-12-04', job: 'Software Developer ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Falgun', last_name: 'Contractor', email: 'falguncontractor87@gmail.com', phone_code: '+49', phone_number: '1729205342', dob: '1987-11-24', job: 'software enfineer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Alistair ', last_name: 'Schofield ', email: 'alistairschofieldeng@gmail.com', phone_code: '+33', phone_number: '767569851', dob: '1996-06-12', job: 'Aerospace Engineering', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: [""], password: 'stacey-living123456789')
# # User.create!(first_name: 'Elias', last_name: 'Bartl', email: 'elias.bartl@icloud.com', phone_code: '+49', phone_number: '17621010465', dob: '1998-08-19', job: 'Chef', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Franziska ', last_name: 'Buhr', email: 'franziska.buhr@web.de', phone_code: '+49', phone_number: '17647664713', dob: '1994-09-02', job: 'Business Development Manager ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sarang', last_name: 'Kulkarni', email: 'sarangk90@gmail.com', phone_code: '+49', phone_number: '15129485665', dob: '1997-08-18', job: 'Software engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Urs', last_name: 'Lünzmann', email: 'ursluenzmann@gmail.com', phone_code: '+49', phone_number: '017624719687', dob: '1991-03-12', job: 'Sound engin ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vitalys ndan', last_name: 'Atumbah', email: 'ndanvitalys@yahoo.com', phone_code: '+49', phone_number: '15213812557', dob: '1991-03-24', job: 'Affiliate Marketing ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Amelie', last_name: 'Schubert', email: 'amelie.schubert@yahoo.com', phone_code: '+49', phone_number: '17684370272', dob: '1990-08-19', job: 'Controlling at Otto Konzern (Hermes)', amount_of_people: 'NO', linkedin: 'Amelie SCHUBERt', facebook: '', twitter: '', instagram: 'hi.i.am.amelie', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Zohaib', last_name: 'Ansari', email: 'zohaibans@gmail.com', phone_code: '+49', phone_number: '15254116104', dob: '1997-08-21', job: 'iM A STUDENT', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Christian', last_name: 'Hundt', email: 'c.hundt@outlook.com', phone_code: '+49', phone_number: '16091459845', dob: '1993-06-29', job: 'Consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Samuel', last_name: 'Prior', email: 'sampri07@hotmail.com', phone_code: '+44', phone_number: '7763770156', dob: '1985-09-03', job: 'Teacher', amount_of_people: 'YES', linkedin: '', facebook: 'facebook.com/sam.prior.85', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ayon', last_name: 'Sanyal', email: 'ayon.sanyal@gmail.com', phone_code: '+49', phone_number: '15124454973', dob: '1988-08-08', job: 'Software Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Basic +", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Toni', last_name: 'Blumenstein', email: 'toni.blumenstein@gmx.de', phone_code: '+49', phone_number: '17662257003', dob: '1987-12-04', job: 'Vertrieb', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Marius', last_name: 'Hermann', email: 'marius.hermann@me.com', phone_code: '+49', phone_number: '1734363008', dob: '1999-07-26', job: 'STUDENT', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Manivannan', last_name: 'Konnai girivasan', email: 'kcgmani2004@gmail.com', phone_code: '+49', phone_number: '15215719491', dob: '1985-09-13', job: 'Software engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anton', last_name: 'Spitkovsky', email: 'anton.spitkovsky@gmail.com', phone_code: '+49', phone_number: '1713175671', dob: '1996-06-12', job: 'Intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'https://www.instagram.com/spitko/?hl=de', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Saleha ', last_name: 'Shaikh', email: 'saleha.shaikh01@gmail.com', phone_code: '+49', phone_number: '15162784027', dob: '1997-08-31', job: 'SOftware employee', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vishesh ', last_name: 'Kumar', email: 'godfather.vishesh@gmail.com', phone_code: '+49', phone_number: '17621314675', dob: '1997-09-01', job: 'Job', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Zeeshan', last_name: 'Haider', email: 'zeeshanhaider87@gmail.com', phone_code: '+49', phone_number: '1789124108', dob: '1987-12-04', job: 'software engineer at free now', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/zeeshanhaider87/', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tanuj', last_name: 'Rajvanshi', email: 'tanuj.nitkkr@gmail.com', phone_code: '+49', phone_number: '15237213041', dob: '1989-12-24', job: 'Product Owner', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'https://www.instagram.com/tanujrajvanshi/?hl=en', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rafael', last_name: 'Oliveira', email: 'rafaelalcance@gmail.com', phone_code: '+372', phone_number: '81072542', dob: '1993-07-15', job: 'Software Engineer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Angelica', last_name: 'Pacheco', email: 'ang.pacheco.m@gmail.com', phone_code: '+49', phone_number: '222222222', dob: '1997-09-04', job: 'DATA scientist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vanesa', last_name: 'Rodriguez acosta', email: 'vanerodriguezac@gmail.com', phone_code: '+49', phone_number: '1784521723', dob: '1989-08-10', job: 'Art director / Designer', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/vanesa-rodriguez-acosta-27554836/', facebook: 'https://www.facebook.com/vanesa.rodriguezacosta', twitter: '', instagram: 'https://www.instagram.com/vanerodriguezacosta/', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jürgen', last_name: 'Schulte-laggenbeck', email: 'j.schulte-laggenbeck@gmx.de', phone_code: '+49', phone_number: '015117152661', dob: '1965-07-23', job: 'CFO', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rajashekar', last_name: 'Chinthalapelly', email: 'shekarreddy568@gmail.com', phone_code: '+49', phone_number: '15212858795', dob: '1992-07-02', job: 'Software Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Hanh', last_name: 'Nguyen', email: 'hanh.nh215@gmail.com', phone_code: '+39', phone_number: '3663418755', dob: '1993-05-21', job: 'Intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Emine', last_name: 'Rustemi', email: 'mina.rustemi2@gmail.com', phone_code: '+49', phone_number: '17662113349', dob: '1991-02-05', job: 'Education in commercial media assistance', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Daniel', last_name: 'Felix reis', email: 'danielfr@gmail.com', phone_code: '+39', phone_number: '3493121880', dob: '1971-06-03', job: 'Dig Nomad', amount_of_people: 'YES', linkedin: 'http://linkedin.com/in/danielfelixreis', facebook: 'Daniel felix reis', twitter: 'Danielfr', instagram: 'Danielfr', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Albana', last_name: 'Bogdani', email: 'bana.bogdani@gmail.com', phone_code: '+355', phone_number: '693049443', dob: '1992-11-03', job: 'Baby sitter ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sonja', last_name: 'Hedtke', email: 'hedtke@gmx.de', phone_code: '+49', phone_number: '1711922245', dob: '1997-09-14', job: 'Consultant (in an Employee-Assistance-Program)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Adissa', last_name: 'Midzan', email: 'a.midzan@gmx.de', phone_code: '+49', phone_number: '1778101899', dob: '1993-08-11', job: 'Junior projectmanager event', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Carina', last_name: 'Seifert', email: 'carina_seifert@hotmail.de', phone_code: '+49', phone_number: '1776706389', dob: '1993-03-18', job: 'Doctor', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '___carrie___', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Marlon', last_name: 'Hurter', email: 'marlon1994@gmx.de', phone_code: '+49', phone_number: '01742995957', dob: '1994-11-21', job: 'Operations Specialist @ Lime', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lea ', last_name: 'Tanson', email: 'leatanson@t-online.de', phone_code: '+43', phone_number: '68110787728', dob: '1999-06-14', job: 'Medical Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Haya', last_name: 'Alatassi', email: 'haya.atassi@gmail.com', phone_code: '+49', phone_number: '17643965618', dob: '1995-02-27', job: 'Social media analyst', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anna', last_name: 'Böttcher', email: 'anna.boettcher17@gmail.com', phone_code: '+49', phone_number: '1727017812', dob: '1994-05-17', job: 'Seo manager (fulltime) + freeLancer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Min seok', last_name: 'Kang', email: 'minsk2517@gmail.com', phone_code: '+49', phone_number: '1735835942', dob: '1993-02-25', job: 'Opernsänger', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tim', last_name: 'Hellwig', email: 'timhaufs@rocketmail.com', phone_code: '+49', phone_number: '15755080858', dob: '2000-01-20', job: 'STudent', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anna', last_name: 'Walter', email: 'annahw89@gmail.com', phone_code: '+49', phone_number: '15257610820', dob: '1989-10-21', job: 'Architect', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nil', last_name: 'Biosca', email: 'nbiosca2q@gmail.com', phone_code: '+34', phone_number: '697941066', dob: '1996-08-09', job: 'Tax CONSULTANt at pwc', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kyley', last_name: 'Rosser', email: 'kyleyrosser99@gmail.com', phone_code: '+49', phone_number: '4915259556890', dob: '1999-05-18', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Matteo', last_name: 'Angione', email: 'angionem6@gmail.com', phone_code: '+39', phone_number: '3492475671', dob: '1994-06-06', job: 'jr. Art director', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lea', last_name: 'Hermanns', email: 'hermanns.h.lea@gmail.com', phone_code: '+49', phone_number: '1707655715', dob: '1997-09-16', job: 'Marketing at Startup', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ahmed', last_name: 'Hassan', email: 'ahmed.hassan.wg@gmail.com', phone_code: '+49', phone_number: '15254804148', dob: '1986-03-15', job: 'Softw Eng ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Johannes', last_name: 'Benthaus', email: 'johannes.benthaus@gmail.com', phone_code: '+49', phone_number: '17631135485', dob: '1994-07-21', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Fernanda', last_name: 'Conceicao dos santos', email: 'darlyninha@hotmail.de', phone_code: '+49', phone_number: '1727264855', dob: '1993-01-19', job: 'Travelmanagerin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rosmarie', last_name: 'Rakow', email: 'rosmarie_rakow@web.de', phone_code: '+49', phone_number: '15121896054', dob: '1988-05-11', job: 'IntensivkrankenschWester', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ilse', last_name: 'Vandroogenbroeck', email: 'ilsevandroogenbroeck@hotmail.com', phone_code: '+32', phone_number: '499189463', dob: '1995-09-30', job: 'Sales assistant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Haya', last_name: 'Alatassi', email: 'haya_atassi@hotmail.com', phone_code: '+49', phone_number: '17643965618', dob: '1997-09-17', job: 'Soc media analyst', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Liana', last_name: 'Bobarov', email: 'liana.melina@mail.ru', phone_code: '+49', phone_number: '157 58035240', dob: '2000-05-16', job: 'University student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jens', last_name: 'Poppe', email: 'jepocera@t-online.de', phone_code: '+49', phone_number: '15154027016', dob: '1970-10-13', job: 'Lehrer STS Niendorf', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Arman', last_name: 'Syed', email: 'syedaarman17@gmail.com', phone_code: '+49', phone_number: '017658619594', dob: '1997-09-21', job: 'Student', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/syedaarman', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Uche', last_name: 'Oteh', email: 'uche.oteh@gmail.com', phone_code: '+49', phone_number: '17651254531', dob: '1985-07-30', job: 'Computer Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Srikanth', last_name: 'Golla', email: 'sgolla06@gmail.com', phone_code: '+49', phone_number: '15212697657', dob: '1983-09-10', job: 'software engineer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Charles', last_name: 'Tandoh', email: 'tandohcharles@gmail.com', phone_code: '+233', phone_number: '247895929', dob: '1985-03-18', job: 'Researcher ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nil', last_name: 'Biosca jimenez', email: 'nbiosca21@gmail.com', phone_code: '+34', phone_number: '697941066', dob: '1996-08-09', job: 'tax consultant (PWC)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Elena', last_name: 'Tacci', email: 'elenatacci@icloud.com', phone_code: '+49', phone_number: '15904525787', dob: '1989-10-21', job: 'accountant ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lukas', last_name: 'Krabbenhöft', email: 'krabbenhoeft@gmx.de', phone_code: '+49', phone_number: '1904097609', dob: '2001-07-04', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leander', last_name: 'Bürk', email: 'leander-buerk@gmx.de', phone_code: '+49', phone_number: '17642129871', dob: '1999-07-15', job: 'Ausbildung', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rene', last_name: 'Navrkal', email: 'renenavrkal@gmail.com', phone_code: '+49', phone_number: '1782067141', dob: '1987-05-27', job: 'I am a recruiter', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lavinia', last_name: 'Höhne', email: 'lavinia.hoehne@gmx.de', phone_code: '+49', phone_number: '160 939 21850', dob: '1990-03-03', job: 'Consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Peter', last_name: 'Reiss', email: 'peter.reiss52@gmail.com', phone_code: '+49', phone_number: '1732520147', dob: '1996-11-05', job: 'Financial Analyst', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Mona', last_name: 'Eden', email: 'mona.eden@gmx.net', phone_code: '+49', phone_number: '15224142516', dob: '1997-07-16', job: 'Field Sales', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Antonia', last_name: 'Rudolf', email: 'antoniarudolf@aol.com', phone_code: '+49', phone_number: '15124190898', dob: '1997-06-26', job: 'Paid internship at EDeka Ag', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Melina', last_name: 'Kaiser', email: 'melina.kaiser@hotmail.com', phone_code: '+49', phone_number: '15785880039', dob: '1996-01-19', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cristian', last_name: 'Obersterescu', email: 'cristian.obersterescu@gmail.com', phone_code: '+49', phone_number: '15222370127', dob: '1995-03-25', job: 'Network Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cord', last_name: 'Schmidt', email: 'cord@helgagoldschmied.com', phone_code: '+49', phone_number: '1701084022', dob: '1992-02-02', job: 'Entrepreneur', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Caroline', last_name: 'Hettler', email: 'carolinesm.hettler@gmail.com', phone_code: '+49', phone_number: '17643418946', dob: '1997-05-17', job: 'Front office agent (BA Hospitality Management)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rishabh', last_name: 'Jain', email: 'work.rishabhjain@gmail.com', phone_code: '+49', phone_number: '15775997227', dob: '1993-02-17', job: 'Freelance designer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Pakorn', last_name: 'Duriyaprasit', email: 'duriyaprasit.p@gmail.com', phone_code: '+49', phone_number: '17635642478', dob: '1988-07-28', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Alicja', last_name: 'Paszkiel', email: 'paszkielalicja@gmail.com', phone_code: '+49', phone_number: '792951414', dob: '1995-08-12', job: 'Artists', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sameer', last_name: 'Kalantre', email: 'kalantre.sameer@gmail.com', phone_code: '+49', phone_number: '1602911046', dob: '1992-06-15', job: 'Software Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Silvan', last_name: 'Beneker', email: 'silvan.beneker@gmail.com', phone_code: '', phone_number: '1637011850', dob: '1996-09-27', job: 'Intern corporate strategy otto group', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Elisabeth', last_name: 'Kogan', email: 'elisabeth.kogan@gmx.de', phone_code: '+49', phone_number: '17681650180', dob: '2000-03-14', job: 'Parents will help as long as i am a student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Aline', last_name: 'Carvalho silva', email: 'alinecarsil@gmail.com', phone_code: '+49', phone_number: '015202190255', dob: '1985-07-03', job: 'microbiologist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jana', last_name: 'Bene', email: 'jana.bene@web.de', phone_code: '+49', phone_number: '17662167579', dob: '1994-06-01', job: 'Campaign & sales manager ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anton', last_name: 'Zaitsev', email: 'zaitsev.anton@yahoo.com', phone_code: '+49', phone_number: '1724608970', dob: '1997-10-01', job: 'apprenticeship - IT Systems Administrator', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Daisy', last_name: 'Edwina', email: 'hsdaisyedwina@gmail.com', phone_code: '+49', phone_number: '17647351929', dob: '1995-05-11', job: 'Student and occupational safety work student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nishant', last_name: 'Vashisth', email: 'nishantvas@yahoo.com', phone_code: '+91', phone_number: '8527234110', dob: '1991-11-08', job: 'Software engineer', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gebenfang', last_name: 'Shi', email: 'shiin2814@gmail.com', phone_code: '+49', phone_number: '15238818142', dob: '2001-01-16', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sheila grace', last_name: 'Tan', email: 'sheilagracetan@gmail.com', phone_code: '+49', phone_number: '1634741410', dob: '1994-09-14', job: 'student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Peiyi', last_name: 'Zhang', email: 'peiyi.z24@yahoo.com', phone_code: '+49', phone_number: '15227747399', dob: '1995-12-24', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Pamela', last_name: 'Lanza', email: 'pamelalacerda@yahoo.com.br', phone_code: '+49', phone_number: '17624316375', dob: '1986-10-20', job: 'System Engineering ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["Basic", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ariel', last_name: 'Galarza', email: 'ariel.galarza@gmx.de', phone_code: '+49', phone_number: '015751515156', dob: '1989-05-29', job: 'Heilerziehungspfleger', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cándido', last_name: 'Domingo castillo', email: 'candidodomingocastillo@gmail.com', phone_code: '+34', phone_number: '683335299', dob: '2000-06-17', job: 'Recepcionist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Pinar', last_name: 'Ciftci', email: 'pinar-c@outlook.com', phone_code: '+33', phone_number: '782234699', dob: '1987-08-20', job: 'I studied business working in sales now', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Beatrise', last_name: 'Zake', email: 'beatrisezake@gmail.com', phone_code: '+371', phone_number: '29153506', dob: '1998-08-07', job: 'STUDENT / THEATRE DIRECTOR AND PRODUCER', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Andra', last_name: 'Visanoiu', email: 'andra.visanoiu@gmail.com', phone_code: '+40', phone_number: '741122524', dob: '1996-08-09', job: 'Student/Intern', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/andra-visanoiu/', facebook: 'https://www.facebook.com/andra.visi', twitter: '', instagram: 'www.instagram/andravisi', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kapil', last_name: 'Makkar', email: 'kapilmakkar2690@gmail.com', phone_code: '+49', phone_number: '15219349101', dob: '1990-03-26', job: ' IT DEVELOPER', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Constanze', last_name: 'Franz', email: 'constanzefranz@web.de', phone_code: '+49', phone_number: '15118293426', dob: '1997-03-20', job: 'Professional in Business Tax', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gurpreet', last_name: 'Singh', email: 'gurpreet.s@hotmail.de', phone_code: '+49', phone_number: '15208662495', dob: '1993-09-01', job: 'intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leon', last_name: 'Behrens', email: 'behrensborkum@gmail.com', phone_code: '+49', phone_number: '17669364010', dob: '1997-06-24', job: 'Hotelfachmann', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tobias ', last_name: 'Lössl', email: 'tobiloessl@hotmail.de', phone_code: '+49', phone_number: '15203198494', dob: '1994-09-28', job: 'Student; Event Arbeit', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Mo', last_name: 'Khalil', email: 'mo.khalil@gmx.net', phone_code: '+49', phone_number: '16098088228', dob: '1998-09-23', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Viviana', last_name: 'Murillo', email: 'vmmurillo09@gmail.com', phone_code: '+34', phone_number: '633426208', dob: '1991-08-09', job: 'Sales MaNager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Daniel', last_name: 'Sánchez diago', email: 'dsanchez.bgs@gmail.com', phone_code: '+34', phone_number: '649285463', dob: '1997-04-06', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Svetlana', last_name: 'Prokhorchik', email: 's.prokhorchik@gmail.com', phone_code: '+49', phone_number: '1781594029', dob: '1995-05-16', job: 'StudenT', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Andrea', last_name: 'Cianfarani', email: 'andrea.cianfarani@hotmail.com', phone_code: '+39', phone_number: '3450884053', dob: '1995-04-03', job: 'Logistics CustOm DOKUMENTATION', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Avan', last_name: 'Naghshbandi', email: 'avan.naghshbandi@gmail.com', phone_code: '+49', phone_number: '15775126415', dob: '2000-03-01', job: 'Student + writer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'charlieavn', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Rebecca', last_name: 'Sunden', email: 'rebeccadaggers@hotmail.com', phone_code: '+46', phone_number: '723815157', dob: '1994-11-17', job: 'Bartender/student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Miriam', last_name: 'Huhuenin', email: 'huguenin.miriam@gmail.com', phone_code: '+49', phone_number: '17645984524', dob: '1987-01-14', job: 'OccUpational therapist, aNd study psychologie ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'David', last_name: 'Höhl', email: 'david.hoehl@aol.com', phone_code: '+49', phone_number: '17630704794', dob: '1996-03-20', job: 'Entrepreneur in residence/ entrepreneur', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tobias ', last_name: 'Lössl', email: 'tobi2809@t-online.de', phone_code: '+49', phone_number: '15203198494', dob: '1997-09-25', job: 'Student; Event Arbeit', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nino', last_name: 'Cakic', email: 'ninoslav.cakic.de@gmail.com', phone_code: '+49', phone_number: '1603489261', dob: '1988-01-27', job: 'Innenarchitekt', amount_of_people: 'NO', linkedin: '', facebook: 'Ninoslav Cakic', twitter: '', instagram: 'kunstlerkopf', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Thomas', last_name: 'Renz', email: 'thomasrenz1989@web.de', phone_code: '+49', phone_number: '15117387372', dob: '1997-09-25', job: 'Director Sales Aviation', amount_of_people: 'NO', linkedin: 'http://linkedin.com/in/thomas-renz-4b466783', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sebastian', last_name: 'Campos', email: 'campos.scm@gmail.com', phone_code: '+49', phone_number: '17622228784', dob: '1991-04-11', job: 'Sr. Associate business development', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sooji', last_name: 'Lee', email: 'sooji926@naver.com', phone_code: '+49', phone_number: '15223088267', dob: '1996-09-26', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'suzy_puravida', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kathrin', last_name: 'Schurr', email: 'kathrinschurr@gmx.net', phone_code: '+49', phone_number: '15236225571', dob: '1992-10-03', job: 'Vertrieblerin/ Associate bei einem Dienstleistungsunternehmen für Beratungen', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/kathrin-schurr-005352a7/?originalSubdomain=de', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Angelo', last_name: 'Arceri', email: 'angeloarceri@live.it', phone_code: '+49', phone_number: '15751033355', dob: '1995-12-30', job: 'Bid management intern', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/angelo-arceri-96761a121/', facebook: 'https://www.facebook.com/profile.php?id=1661320696', twitter: '', instagram: '', prefered_suite: [""], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kristina', last_name: 'Löffel', email: 'km.loeffel@gmx.de', phone_code: '+49', phone_number: '015750495109', dob: '1978-03-31', job: 'Dipl.-Sozialpädagogin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vera', last_name: 'Sabas', email: 'sabasvera@gmail.com', phone_code: '+49', phone_number: '1776208093', dob: '1985-03-13', job: 'Education for Hairdressers', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sungyeon', last_name: 'Kwon', email: 'megalopsychon0@gmail.com', phone_code: '+49', phone_number: '015237840156', dob: '1992-03-07', job: 'FREIGHT FORWARDER IN SPEDITION', amount_of_people: 'NO', linkedin: 'www.linkedin.com/in/sung-yeon-kwon-8b2a15153', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Carlos', last_name: 'Aponte', email: 'caat91@gmail.com', phone_code: '+49', phone_number: '1718330574', dob: '1991-01-20', job: 'It COnsultant and developer', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/capontetoro/', facebook: ' https://www.facebook.com/capontetoro', twitter: '', instagram: 'https://www.instagram.com/capontetoro/', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Victoria', last_name: 'Tao ', email: 'taovictoria921@gmail.com', phone_code: '+49', phone_number: '176506t03903', dob: '1990-09-21', job: 'Student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Durgesh', last_name: 'Pandey', email: 'pandey.durgesh0786@gmail.com', phone_code: '+49', phone_number: '17667706210', dob: '1993-10-20', job: 'Software Engineer ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nil', last_name: 'Biosca jimenez', email: 'nil.biosca.jimenez@pwc.com', phone_code: '+34', phone_number: '697941066', dob: '1997-10-05', job: 'tax consultant (PWC)', amount_of_people: 'NO', linkedin: 'nilbiosca', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Victoria', last_name: 'Bracamontes vazquez', email: 'vbracamontes.bss@gmail.com', phone_code: '+52', phone_number: '6862615404', dob: '1994-08-03', job: 'ELectrical Design Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Seonhwa', last_name: 'Roh', email: 'seonhwaroh@gmail.com', phone_code: '+49', phone_number: '17683028158', dob: '1992-11-07', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tatiana', last_name: 'Mamiy', email: 'tatiana.mamiy@gmail.com', phone_code: '+49', phone_number: '017662772717', dob: '1984-09-28', job: 'Senior HR Partner Global at Gebr. HEINEMANN', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/tatiana-mamiy-39b2b54a', facebook: 'https://www.facebook.com/tatiana.mamiy', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nisar ', last_name: 'Shaikh ', email: 'snaindus@gmail.com', phone_code: '+49', phone_number: '15216920272', dob: '1980-01-01', job: 'Self e ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Chaithanya', last_name: 'Chennareddy', email: 'chaithanya.sln@gmail.com', phone_code: '+49', phone_number: '17658130114', dob: '1991-03-19', job: 'Permanent Job', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Markus', last_name: 'Flege', email: 'mail@markusflege.com', phone_code: '+49', phone_number: '1754302797', dob: '1996-12-29', job: 'Intern - ZEIT VERLAG', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Salim', last_name: 'Jahn', email: 'salimjahn@googlemail.com', phone_code: '+49', phone_number: '1627421677', dob: '1997-10-12', job: 'real estate agent selling', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Maxim', last_name: 'Dvornikov', email: 'maxim.dvornikov@hotmail.com', phone_code: '+7', phone_number: '9653316920', dob: '1978-03-24', job: 'researcher', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Adriane', last_name: 'Leibhammer', email: 'mailtoadri@web.de', phone_code: '+49', phone_number: '15142677034', dob: '1998-05-22', job: 'Paid Internship', amount_of_people: 'NO', linkedin: 'Adriane Leibhammer', facebook: '', twitter: '', instagram: '4drile', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Felix', last_name: 'Ludwig', email: 'felix_ludwig@me.com', phone_code: '+49', phone_number: '17661026304', dob: '1997-10-17', job: 'Civil engIneer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jessica', last_name: 'Geyer', email: 'jessica_geyer94@gmx.de', phone_code: '+49', phone_number: '152598074', dob: '1994-06-27', job: 'CamPaign Managerin', amount_of_people: 'NO', linkedin: 'Jessica Geyer', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Musa', last_name: 'Kocaman', email: 'musa.kocaman@siemensgamesa.com', phone_code: '+90', phone_number: '538 5747387', dob: '1991-08-31', job: 'ELECTRICAL ENGINEER AT SIEMENS', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/musa-kocaman-ab7641a1/', facebook: 'https://www.facebook.com/musakocamann', twitter: 'https://twitter.com/musakocaman', instagram: 'https://www.instagram.com/musakocaman/', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nazila', last_name: 'Golchin', email: 'nazila.golchin@gmail.com', phone_code: '+49', phone_number: '015225447287', dob: '1983-03-20', job: 'Java developer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nil', last_name: 'Biosca jimenez', email: 'nil.biosca01@estudiant.upf.edu', phone_code: '+49', phone_number: '697941066', dob: '1996-08-09', job: 'tax consultant (PWC)', amount_of_people: 'NO', linkedin: 'linkedin.com/in/nilbisoc', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anna-maria', last_name: 'Avramidou', email: 'annamaria_91@windowslive.com', phone_code: '+49', phone_number: '017689126465', dob: '1997-10-29', job: 'Erzieherin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Paul', last_name: 'Fröhlich', email: 'paul.froehlich@gmx.net', phone_code: '+49', phone_number: '17643306004', dob: '1997-10-30', job: 'ResEarch Assistant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Emmanuel ', last_name: 'Obasi', email: 'rexreginald@yahoo.com', phone_code: '+370', phone_number: '64589069', dob: '1997-10-31', job: 'Sport man and worker', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Christian', last_name: 'Ritterbach', email: 'ch.ritterbach@t-online.de', phone_code: '+49', phone_number: '1725163157', dob: '1993-09-10', job: 'Strategy Trainee at E.ON (european energy Utility)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Eva', last_name: 'Dessers', email: 'desserseva1@gmail.com', phone_code: '+32', phone_number: '476505740', dob: '1997-09-19', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Eva', last_name: 'Böttcher', email: 'eva.boettcher@bc-boettcher.de', phone_code: '+49', phone_number: '01703124327', dob: '1968-04-30', job: 'Head of HR', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Yves', last_name: 'Bontje', email: 'yves.bontje@gmail.com', phone_code: '+31', phone_number: '0617456021', dob: '1983-03-16', job: 'GM', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tdisuarmur', last_name: 'Mupriowycco', email: 'everettlightburn@yahoo.com', phone_code: '+93', phone_number: '8955436598', dob: '1949-02-02', job: 'pdkAefDGR', amount_of_people: 'YES', linkedin: 'dUTiGYbDVMjeESz', facebook: 'SvMgQbrieYd', twitter: 'zFoXsjTK', instagram: 'GXUIcRrAvldWS', prefered_suite: ["Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Chandra pal', last_name: 'Singh', email: 'chandrapalsingh63@gmail.com', phone_code: '+49', phone_number: '15144907281', dob: '1990-12-01', job: 'Job', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anastasia', last_name: 'Krieg', email: 'anastasia.krieg@t-online.de', phone_code: '+49', phone_number: '1732161479', dob: '1999-03-17', job: 'Student', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/sofie-anastasia-krieg-a92b93181/', facebook: 'https://www.facebook.com/anastasia.krieg', twitter: '', instagram: 'https://www.instagram.com/anastasiakrg/', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Dorotea', last_name: 'Mircetic', email: 'doroteamircetic123@gmail.com', phone_code: '+45', phone_number: '91782098', dob: '1996-11-01', job: 'Waitr ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Olympia', last_name: 'Simopoulou', email: 'osimopoulou@gmail.com', phone_code: '+44', phone_number: '7904201945', dob: '1992-11-18', job: 'ArchitectUral designer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Haylie', last_name: 'Wanamaker', email: 'hwanamaker@hotmail.com', phone_code: '+49', phone_number: '15003865512', dob: '1991-08-08', job: 'Bar', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vanessa', last_name: 'Kröger', email: 'miss.kroeger@web.de', phone_code: '+49', phone_number: '1779543061', dob: '1994-07-09', job: 'Erzieherin/ educator', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vanessa', last_name: 'Mölck', email: 'va.mk@t-online.de', phone_code: '+49', phone_number: '015206582634', dob: '1997-12-04', job: 'Marketing', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leona', last_name: 'Unrath', email: 'leona.unrath@web.de', phone_code: '+49', phone_number: '17631706876', dob: '1998-04-16', job: 'Student/intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anastasia', last_name: 'Ilina', email: 'nas.ilina@gmail.com', phone_code: '+44', phone_number: '07562964110', dob: '1996-07-13', job: 'engineering consultant, big international firm', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/anastasiailina/', facebook: '', twitter: '', instagram: 'http://instagram.com/nastiailina', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Margret karoline', last_name: 'Hahn', email: 'margret89.mh@gmail.com', phone_code: '+49', phone_number: '015170121447', dob: '1989-12-24', job: 'Customer Service Management ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'mhmaggie1989', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nathalie ', last_name: 'Sautter ', email: 'nathaliesautter04@gmail.com', phone_code: '+49', phone_number: '15254703852', dob: '1990-04-09', job: 'Teacher', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jeanne', last_name: 'Lamotte', email: 'lamotte.jeanne@gmail.com', phone_code: '+33', phone_number: '673323908', dob: '1997-11-07', job: 'Student/Verkäuferin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Egemen', last_name: 'Özkan', email: 'egemen.kerem.ozkan@gmail.com', phone_code: '+49', phone_number: '015750453243', dob: '1993-04-23', job: 'Architekt', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kilian', last_name: 'Witte', email: 'kilian.witte@outlook.de', phone_code: '+49', phone_number: '1784062190', dob: '1991-09-18', job: 'Working Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'kalainoo', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Canan ', last_name: 'Arslan ', email: 'canan.arslan@hotmail.de', phone_code: '+49', phone_number: '15168132604', dob: '1986-08-04', job: 'AErounatical engineer ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Melania', last_name: 'Rodríguez olmo', email: 'melania280493@gmail.com', phone_code: '+34', phone_number: '684082180', dob: '1993-04-28', job: 'airbus job', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gema', last_name: 'Barrales alcain', email: 'gemabaral11@gmail.com', phone_code: '+34', phone_number: '648607232', dob: '1994-12-11', job: 'Engineering consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Júlio césar', last_name: 'Carvalho francisco dos santos', email: 'jccarvalhof@gmail.com', phone_code: '+49', phone_number: '1726521351', dob: '1997-06-20', job: 'INtern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Bahaa-eldin', last_name: 'Ismail', email: 'bahaa_allam@ymail.com', phone_code: '+20', phone_number: '1008086998', dob: '1986-08-20', job: 'Digital Nomad (Copywriter and Localizer)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Renato', last_name: 'Dourado', email: 'renato_dourado@hotmail.com', phone_code: '+49', phone_number: '17677595871', dob: '1981-08-11', job: 'Finance market', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sungyeon', last_name: 'Kwon', email: 'lbell92@naver.com', phone_code: '+49', phone_number: '15237840156', dob: '1997-12-10', job: 'forwarder in logistic company', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Aakshi', last_name: 'Taneja', email: 'aakshi.175@gmail.com', phone_code: '+49', phone_number: '176591427573', dob: '1990-05-17', job: 'I work in a Risk Management Dept in a bank ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Max', last_name: 'Finkler', email: 'finkler.max@posteo.de', phone_code: '+49', phone_number: '176/98469179', dob: '1995-08-24', job: 'electronic technician for system and devices', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Manoj', last_name: 'Thakur', email: 'sspmkt@gmil.com', phone_code: '+49', phone_number: '15226683509', dob: '1978-04-22', job: 'JOB', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Shirin', last_name: 'Dadgarazad', email: 'shirin.azad68@gmail.com', phone_code: '+49', phone_number: '1778734099', dob: '1990-03-16', job: 'Student', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Alex', last_name: 'Alves', email: 'alex.21.alves@gmail.com', phone_code: '+49', phone_number: '17620165891', dob: '1993-06-18', job: 'Marketing trainee', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Catherine', last_name: 'Roderbourg', email: 'catherine.roderbourg@hotmail.com', phone_code: '+32', phone_number: '496553474', dob: '1997-01-08', job: 'intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Christoffer', last_name: 'Woost', email: 'christoffer.woost@devnado.de', phone_code: '+49', phone_number: '15173072242', dob: '1997-10-13', job: 'Software developer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Joshua', last_name: 'Hiddemann', email: 'joshua.hiddemann@rats-os.de', phone_code: '+49', phone_number: '1743417624', dob: '1995-01-07', job: 'WirtschaftsjuriSt/Werkstudent', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Asa ', last_name: 'Bong', email: 'bongac@mail.broward.edu', phone_code: '+1', phone_number: '9546246331', dob: '1997-12-13', job: 'Aspiring Professional photograPher', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jo-anne', last_name: 'Jaegermann', email: '1629417jaegermann@zuyd.nl', phone_code: '+31', phone_number: '620024291', dob: '1998-12-17', job: 'Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Montserrat', last_name: 'Rodriguez ', email: 'a01632374@itesm.mx', phone_code: '+49', phone_number: '3338154625', dob: '1997-12-22', job: 'student ', amount_of_people: 'NO', linkedin: '', facebook: 'montse rdz', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Bjoern marbod karl', last_name: 'Mueller', email: 'mueller.bjoernmk@outlook.de', phone_code: '+49', phone_number: '15110031372', dob: '2000-02-05', job: 'Front office agent at hilton hotels', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Dennis', last_name: 'Visser', email: 'dennis@halasz.nl', phone_code: '+31', phone_number: '620856523', dob: '2000-07-26', job: 'Intern Happycar gmbh', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Unai', last_name: 'Llantino', email: 'unaiformacion.tma@outlook.es', phone_code: '+43', phone_number: '646349455', dob: '1997-12-16', job: 'Aircraft maintenance', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Unai', last_name: 'Llantino', email: 'unaillantino.smrvb@gmail.com', phone_code: '+49', phone_number: '646349455', dob: '1997-12-16', job: 'Aircraft maintenance', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Maryam', last_name: 'Tohidi-moghaddam', email: 'tohidimm88@yahoo.com', phone_code: '+49', phone_number: '15237983996', dob: '1991-03-21', job: 'I am studying my Phd', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sudharsan', last_name: 'Ms', email: 'webdev.sudhi@gmail.com', phone_code: '+971', phone_number: '559676521', dob: '1989-03-17', job: 'Frontend software engineer ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sophia ', last_name: 'Zießler', email: 'sophia.ziessler@gmx.de', phone_code: '+49', phone_number: '1704791637', dob: '1997-12-16', job: 'Marketing Manager in einer IT-Firma', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lucie', last_name: 'Chorvatova', email: 'chorvatova.lucie@gmail.com', phone_code: '+49', phone_number: '15788035007', dob: '1997-12-16', job: 'Marketing ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vanessa', last_name: 'Römer', email: 'vanessa.roemer@online.de', phone_code: '+49', phone_number: '15205130075', dob: '1998-05-15', job: 'student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Vanessa', last_name: 'Römer', email: 'vanessa.roemer@student.reutlingen-university.de', phone_code: '+49', phone_number: '15205130075', dob: '1998-05-15', job: 'student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Carina', last_name: 'Köser', email: 'carina.koser@gmail.com', phone_code: '+49', phone_number: '1743270339', dob: '1997-12-18', job: 'Intern', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Minky', last_name: 'Chun', email: 'mk870117@gmail.com', phone_code: '+49', phone_number: '15125851138', dob: '1987-01-17', job: 'hotel receptionist ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Lisa', last_name: 'Knoops', email: 'lisa_kn@outlook.com', phone_code: '+49', phone_number: '486641095', dob: '1997-12-18', job: 'internship', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Leonie', last_name: 'Dammann', email: 'leonie.dammann@gmx.de', phone_code: '+49', phone_number: '01727552679', dob: '1995-07-28', job: 'Internship at eventim', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jesco', last_name: 'Ste ', email: 'j.sterll@t-online.de', phone_code: '+49', phone_number: '15124888424‬‬', dob: '1997-12-18', job: 'Kellner', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Hannah ', last_name: 'Stauss', email: 'hannah.stauss@web.de', phone_code: '+49', phone_number: '16097933077', dob: '1997-12-18', job: 'Med student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Nazila', last_name: 'Golchin', email: 'nazila.golchin@4elements-gruppe.de', phone_code: '+49', phone_number: '15225447287', dob: '1983-03-20', job: 'Java developer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Fiona', last_name: 'Pozzi', email: 'fionapozzi@gmail.com', phone_code: '+54', phone_number: '1151745778', dob: '1985-08-23', job: 'Study and work', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cara', last_name: 'Hitchens', email: 'carahitchens@icloud.com', phone_code: '+49', phone_number: '1789315752', dob: '1998-10-09', job: 'Travelling ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'David', last_name: 'Schrittenlocher', email: 'davidschrittenlocher@hotmail.com', phone_code: '+49', phone_number: '17677455490', dob: '1997-12-19', job: 'Restaurantfachmann im east ', amount_of_people: 'YES', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Ann cecilia', last_name: 'Reder', email: 'a.reder@live.de', phone_code: '+49', phone_number: '1751064880', dob: '1997-12-19', job: 'Studentin', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Andrew', last_name: 'Reyes', email: 'andrewreyesde@gmail.com', phone_code: '+49', phone_number: '015170389893', dob: '1989-02-15', job: 'E-CommerCe Consulting', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Anke', last_name: 'Wurpts', email: 'ankewu@gmail.com', phone_code: '+49', phone_number: '1638460424', dob: '1984-08-14', job: 'It Support Specialist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Gino', last_name: 'Lodola', email: 'gino.lodola@hotmail.com', phone_code: '+49', phone_number: '040 808190269', dob: '1997-12-20', job: 'Account Manager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium", "Jumbo"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Megha', last_name: 'Sabi', email: 'megharathore@gmail.com', phone_code: '+49', phone_number: '7444684537', dob: '1997-12-20', job: 'Accountmanage ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Kevin', last_name: 'Bürmann', email: 'kevin8690@hotmail.com', phone_code: '+49', phone_number: '1736305965', dob: '1997-12-20', job: 'Souschef', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Robert', last_name: 'Diekötter', email: 'robert-diekoetter@t-online.de', phone_code: '+49', phone_number: '15203485521', dob: '1996-12-29', job: 'Koch ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Adrian', last_name: 'Staude', email: 'as@adrianstaude.de', phone_code: '+49', phone_number: '1709295969', dob: '1997-12-21', job: 'Software Developer / Consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Julio ', last_name: 'Carvalho francisco dos santos', email: 'jcarvalho@karlshochschule.de', phone_code: '+49', phone_number: '1726521351', dob: '1997-06-20', job: 'intern at free now', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Klara-luisa', last_name: 'Nett', email: 'klaraistnett@gmail.com', phone_code: '+49', phone_number: '01783208896', dob: '1994-01-03', job: 'Business psychologist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Jan philip', last_name: 'Rieken', email: 'rieken.j.philip@gmail.com', phone_code: '+49', phone_number: '1637745370', dob: '1991-12-18', job: 'Apprentice', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Joachim', last_name: 'Bizot', email: 'joachim.bizot@outlook.fr', phone_code: '+49', phone_number: '+33 778203865', dob: '1997-12-23', job: 'STudent in Internship ', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/in/joachim-bizot-62880a170/', facebook: 'https://www.facebook.com/joachim.bizot', twitter: '', instagram: 'https://www.instagram.com/joachimbizot/?hl=fr', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Pierre', last_name: 'Guillaume', email: 'pierre.guillaume@audencia.com', phone_code: '+33', phone_number: '646775830', dob: '1996-03-27', job: 'Internship', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sourabh', last_name: 'Sirdesai', email: 'sourabhsirdesai5@gmail.com', phone_code: '+49', phone_number: '17634309984', dob: '1993-08-06', job: 'Consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Julia', last_name: 'Bahn', email: 'julia.bahn@hotmail.de', phone_code: '+49', phone_number: '1727103427', dob: '1997-12-26', job: 'Stage Designer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Marcella', last_name: 'Dreyling', email: 'marcella.dreyling@hotmail.de', phone_code: '+49', phone_number: '1715275634', dob: '1995-01-03', job: 'Internship (marketing, Unilever)', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Helen', last_name: 'Kearney', email: 'helenkearn@gmail.com', phone_code: '+353', phone_number: '857108294', dob: '1991-06-12', job: 'Scientist', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sudharsan', last_name: 'Sreedharan', email: 'sudharsan.m.s@gmail.com', phone_code: '+971', phone_number: '559676521', dob: '1989-03-17', job: 'Software Engineer', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Sonja', last_name: 'Sterzik', email: 'sonja.sterzik@gmx.net', phone_code: '+49', phone_number: '1784481410', dob: '1998-09-22', job: 'Dualer Student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Javier', last_name: 'Randez garbayo', email: 'javier_93_rg@hotmail.com', phone_code: '+34', phone_number: '696170554', dob: '1993-02-04', job: 'Phd at the University medical center hamburg eppendorf', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Tobias', last_name: 'Schepers', email: 'tobias.schepers@gmx.de', phone_code: '+49', phone_number: '15118294249', dob: '1994-09-12', job: 'ManagEment consultant', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Fanny', last_name: 'Kammerloher', email: 'fannykammerloher@web.de', phone_code: '+49', phone_number: '01777395972', dob: '1997-03-29', job: 'Intern and Student', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Amin', last_name: 'Lagha', email: 'aimn81@gmx.de', phone_code: '+49', phone_number: '1779295640', dob: '1981-03-29', job: 'Projektmanager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Pia', last_name: 'Ehlers', email: 'pia.ehlers98@gmx.de', phone_code: '+49', phone_number: '1744278785', dob: '1998-12-10', job: 'I´m a student for tourism management in bremerhaven, but i´ll be in the city for a paid internship at the cunard line.', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: 'piaaaaa_e', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Josephin', last_name: 'Brewitt', email: 'josephin-brewitt@web.de', phone_code: '+49', phone_number: '17685035284', dob: '1994-07-04', job: 'Architecture', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Volker ', last_name: 'Kieks ', email: 'francisco.kieks.ariza@gmail.com', phone_code: '+57', phone_number: '3015157826', dob: '1988-10-04', job: 'Kaufmann in Handel', amount_of_people: 'NO', linkedin: 'https://www.linkedin.com/comm/in/francisco-kieks-ariza-48850bb7?midToken=AQEWqWx30kR_vw&trk=eml-jobs_jymbii_digest-header-31-profile&trkEmail=eml-jobs_jymbii_digest-header-31-profile-null-6vv36w%7Ek4ym5m41%7Ev2-null-neptune%2Fprofile%7Evanity%2Eview&lipi=urn%3Ali%3Apage%3Aemail_jobs_jymbii_digest%3BcvKdxyufTrm%2Ba8fAuzuKpg%3D%3D', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Beatrice', last_name: 'Ferranti', email: 'bferranti8@gmail.com', phone_code: '+49', phone_number: '15165205641', dob: '1994-04-18', job: 'Office Manager Hamburg', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Max', last_name: 'Richter', email: 'richter.maximilian.1@gmx.de', phone_code: '+49', phone_number: '15207070790', dob: '1990-07-07', job: 'Befrachter', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Premium"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Craig', last_name: 'Maas', email: 'jdefran7@kent.edu', phone_code: '+49', phone_number: '17674587329', dob: '1998-01-06', job: 'Business analyst and operations manager', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Cecilie ', last_name: 'Nellemos pedersen', email: 'cecliepedersen@ymail.com', phone_code: '+45', phone_number: '29672705', dob: '2000-05-06', job: 'SAILES TRAINEE with focus on social media', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty"], password: 'stacey-living123456789')
# # User.create!(first_name: 'Yan', last_name: 'Jin', email: 'jinyanjiejie@gmail.com', phone_code: '+49', phone_number: '015206021914', dob: '1998-01-07', job: 'student ', amount_of_people: 'NO', linkedin: '', facebook: '', twitter: '', instagram: '', prefered_suite: ["", "Mighty", "Premium", "Jumbo"], password: 'stacey-living123456789')
