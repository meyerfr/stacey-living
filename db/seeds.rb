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

def handle_string_io_as_file(io)
  return io unless io.class == StringIO

  file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
  file.binmode
  file.write io.read
  file.open
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


# Muehlenkamp
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
muehlenkamp_mighty = muehlenkamp.roomtypes.create!(name: 'Mighty', size: 8)

muehlenkamp_premium = muehlenkamp.roomtypes.create!(name: 'Premium', size: 13)

muehlenkamp_premium_plus = muehlenkamp.roomtypes.create!(name: 'Premium+', size: 15)

muehlenkamp_jumbo = muehlenkamp.roomtypes.create!(name: 'Jumbo', size: 25, amount_of_people: 2)

muehlenkamp_photos = {
  muehlenkamp_community_area => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305506/Muehlenkamp/Community/JDVGtf5XQKKU04eAbpVGoA_thumb_10e.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305505/Muehlenkamp/Community/HcSj5Kp6Sdi4XinvCWPd4Q_thumb_dc.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305502/Muehlenkamp/Community/vFA9JCMcTjWI8OL4SuuIIQ_thumb_a3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305498/Muehlenkamp/Community/3NAop8mzQgCjDot3VMQ2Ag_thumb_f4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305504/Muehlenkamp/Community/QqTm5JToSZia_LVc7stfGQ_thumb_bf.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305504/Muehlenkamp/Community/tbEIKPCxTjm3djJAHGx4sg_thumb_bc.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305502/Muehlenkamp/Community/EIYZB8ivSL_Me7P8eC1JYA_thumb_95.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305501/Muehlenkamp/Community/b_06CW77RI_4mee8FNt16g_thumb_9b.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305497/Muehlenkamp/Community/UNADJUSTEDNONRAW_thumb_113.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305495/Muehlenkamp/Community/UNADJUSTEDNONRAW_thumb_111.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305494/Muehlenkamp/Community/9DOqWt7fSImACXkALYggQg_thumb_124.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305495/Muehlenkamp/Community/L_TfMlHdRJCPOtYSZCauTQ_thumb_e8.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305505/Muehlenkamp/Community/Em_yXaqoSUySsGf6YxR6zA_thumb_e3.jpg')
  ],
  muehlenkamp_mighty => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305544/Muehlenkamp/Mighty/eAX0adO0SQGx35a9vy7APw_thumb_129.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305544/Muehlenkamp/Mighty/SDzfpI1bSeu2a3P9kuRgRQ_thumb_133.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305543/Muehlenkamp/Mighty/uvX94s4HQSumDZUCmEvWgA_thumb_12b.jpg')
  ],
  muehlenkamp_premium => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776624/Muehlenkamp/Premium/muehlenkamp_premium_2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776586/Muehlenkamp/Premium/muehlenkamp_premium_1.jpg')
  ],
  muehlenkamp_premium_plus => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/EQXzU0UJRcWW7H8T3nrNMQ_thumb_2a4.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/U_f4M1tPRg_aIfntPKkoNw_thumb_2a2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/4puZFG9ESPSGy_hIXnIexw_thumb_2a5.jpg')
  ],
  muehlenkamp_jumbo => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305526/Muehlenkamp/Jumbo/xg8xDsPIQA_50qjnQprtEA_thumb_7d.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305524/Muehlenkamp/Jumbo/7qBWokpDQF_aLyAKMyYcIA_thumb_8c.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305522/Muehlenkamp/Jumbo/ELYyajx2Rs6jvE3UMI6_5w_thumb_86.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305522/Muehlenkamp/Jumbo/gidwWRV5QQqtOtKCA4s0LQ_thumb_7e.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305520/Muehlenkamp/Jumbo/qEm1_rrbTLuSfKCB_K_V_w_thumb_77.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305518/Muehlenkamp/Jumbo/WuJcgQ0CQyuBrn4Up1CK7A_thumb_6b.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305518/Muehlenkamp/Jumbo/qDZes3GUQJezro1NM7Tl0w_thumb_64.jpg')
  ]
}

puts('attach photos to muehlenkamp roomtypes and community area')
attach_photos(muehlenkamp_photos)

muehlenkamp_room_descriptions = {
  muehlenkamp_mighty => "Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.",
  muehlenkamp_premium => "Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  muehlenkamp_premium_plus => "Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  muehlenkamp_jumbo => "Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m2 designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding."
}

puts('create muehlenkamp roomtypes descriptions')
create_descriptions(muehlenkamp_room_descriptions)

muehlenkamp_roomtypes_prices = {
  muehlenkamp_mighty => {'3-5 Months': 745, '6-8 Months': 695, '9+ Months': 645},
  muehlenkamp_premium => {'3-5 Months': 845, '6-8 Months': 795, '9+ Months': 745},
  muehlenkamp_premium_plus => {'3-5 Months': 895, '6-8 Months': 845, '9+ Months': 795},
  muehlenkamp_jumbo => {'3-5 Months': 1045, '6-8 Months': 995, '9+ Months': 945}
}

puts('create muehlenkamp roomtypes prices')
create_prices(muehlenkamp_roomtypes_prices)

muehlenkamp_roomtypes_rooms_info = {
  muehlenkamp_mighty => {
    "D05" => "3b 1.OG rechts",
    "D07" => "3b 2.OG rechts",
    "D09" => "3b 2.OG links",
    "D10" => "3 EG links",
    "D11" => "3 EG links",
    "D13" => "3 EG rechts",
    "D14" => "3 EG rechts",
    "D16" => "5 1.OG rechts",
    "D19" => "5 2.OG links",
    "D22" => "3 2.OG links",
    "D25" => "5 EG links",
    "D27" => "5 EG links",
    "D28" => "5 EG links",
    "D29" => "5a 1.OG rechts",
    "D30" => "5a 1.OG rechts",
    "D32" => "5a 2.OG rechts",
    "D33" => "5a 2.OG rechts",
    "D35" => "5a 2.OG links"
    # "D38" => "3a 1.OG rechts",
    # "D39" => "3a EG links",
    # "D40" => "3a EG links",
    # "D42" => "3a 1.OG links",
    # "D43" => "3a 1.OG links",
    # "D46" => "3c 1.OG links",
    # "D48" => "3b 1.OG links",
    # "D50" => "3c EG rechts",
    # "D52" => "5a EG rechts",
    # "D53" => "5a EG rechts"
  },
  muehlenkamp_premium => {
    "D01" => "3d 2.OG",
    "D02" => "3d 2.OG",
    "D03" => "3d 2.OG",
    "D17" => "5 1.OG rechts",
    "D20" => "5 2.OG links",
    "D23" => "3 2.OG links"
  },
  muehlenkamp_premium_plus => {
    "D12" => "3 EG links",
    "D15" => "3 EG rechts",
    "D18" => "5 1.OG rechts",
    "D21" => "5 2.OG links",
    "D24" => "3 2.OG links",
    "D26" => "5 EG links",
    "D31" => "5a 1.OG rechts",
    "D34" => "5a 2.OG rechts"
    # "D41" => "3a EG links",
    # "D44" => "3a 1.OG links",
    # "D51" => "5a EG rechts"
  },
  muehlenkamp_jumbo => {
    "D04" => "3b 1.OG rechts",
    "D06" => "3b 2.OG rechts",
    "D08" => "3b 2.OG links",
    "D36" => "5a 2.OG links"
    # "D37" => "3a 1.OG rechts",
    # "D45" => "3c 1.OG links",
    # "D47" => "3b 1.OG links",
    # "D49" => "3c EG rechts"
  }
}

puts('create muehlenkamp rooms')
create_rooms(muehlenkamp_roomtypes_rooms_info)


# Eppendorf
puts('create Eppendorf Project')
eppendorf = Project.create!(name: 'Eppendorf')

puts('create Eppendorf description')
eppendorf.descriptions.create!(field: 'project info index', content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in Eppendorf is just as energetic as the neighborhood.')
eppendorf.descriptions.create!(field: 'project info show', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!")

puts('create Eppendorf Address')
eppendorf_address = eppendorf.create_address!(street: 'Eppendorfer Weg', number: '270', city: 'Hamburg', zip: '20251', country: 'Germany')
puts('create Eppendorf Address description')
eppendorf_address.create_description!(field: 'address info', content: 'Our first location is located in one of the most liveable districts in Hamburg. What can you expect? Restaurants, bars and  cafes in front of your doorstep. It is your decision whether to spend a warm summer day at the Alster or meet with your roommates in our community spaces for a cold beer after work.')

puts('create Eppendorf Community Area')
eppendorf_community_area = eppendorf.community_areas.create!(name: "common space #{eppendorf.name}", size: 100)
puts('create Eppendorf Community Area description')
eppendorf_community_area.descriptions.create!(field: 'common space description', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\nOur 100m2 of community space at ground level comes with:")

puts('create Eppendorf Roomtypes')
eppendorf_mighty = eppendorf.roomtypes.create!(name: 'Mighty', size: 10)
eppendorf_mighty_plus= eppendorf.roomtypes.create!(name: 'Mighty+', size: 10)

eppendorf_premium = eppendorf.roomtypes.create!(name: 'Premium', size: 12)
eppendorf_premium_balcony = eppendorf.roomtypes.create!(name: 'Premium (balcony)', size: 12)

eppendorf_premium_plus = eppendorf.roomtypes.create!(name: 'Premium+', size: 14)
eppendorf_premium_plus_balcony = eppendorf.roomtypes.create!(name: 'Premium+ (balcony)', size: 14)

eppendorf_jumbo = eppendorf.roomtypes.create!(name: 'Jumbo', size: 17)

eppendorf_photos = {
  eppendorf_community_area => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305095/Eppendorf/Community/L7VC3pucSmGuSldp5ZdqJA_thumb_1aa.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305091/Eppendorf/Community/UNADJUSTEDNONRAW_thumb_18a.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305090/Eppendorf/Community/FTIjlYPSQZm0OrV8Rdf4tw_thumb_182.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/Zyn9S_e3TEWs_wUnIuNT5w_thumb_190.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/829vH1IFTEWAxXeTrL_cEQ_thumb_18e.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/GrZ83xNZQICs1Pz_hEhMXg_thumb_17b.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305040/Eppendorf/Community/UwH7caRSQNS_uxb5TnCU2g_thumb_173.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305084/Eppendorf/Community/lIXRCIrxSzalnuxX7onN1A_thumb_162.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305086/Eppendorf/Community/uy8xnX42TVq_A3III_YkRA_thumb_169.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305040/Eppendorf/Community/F1yPZYuuRKOPjl9LZMJVSg_thumb_15c.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305085/Eppendorf/Community/tp2OFgvZS6uyBLllP7q_fQ_thumb_15f.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305046/Eppendorf/Community/JN7MfQjRTAKybAA1aX_kVA_thumb_1c3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305096/Eppendorf/Community/D3iLLYUSSCQ3Z4ug_9OhA_thumb_1b6.jpg')
  ],
  eppendorf_mighty => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/ZZqSpUpLRzyFoNkRUyI6og_thumb_248.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/vuxOG5GERoSmkdBb2S53oQ_thumb_247.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/4ldkRKe0QrGF5q9O634zPw_thumb_241.jpg')
  ],
  eppendorf_premium => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305177/Eppendorf/Premium/4GMt5Br5QzOfc9hmldcreA_thumb_226.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305187/Eppendorf/Premium/LzFIsX6TSru0jnYIht0cMA_thumb_1f3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305177/Eppendorf/Premium/Tj8D6dYATLS3hxxspLO_fw_thumb_1db.jpg')
  ],
  eppendorf_premium_plus => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305210/Eppendorf/PremiumPlus/xI0FTJCQNeo_2ZyYcTpsw_thumb_25d.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305210/Eppendorf/PremiumPlus/BJ6QZ4F6QVGFESoF27pSLg_thumb_25f.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305209/Eppendorf/PremiumPlus/XCdfKPfQQ_27Tl3gGq1JWQ_thumb_261.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305209/Eppendorf/PremiumPlus/R6U0JvmhQDiXhPUyi9FAEg_thumb_26b.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305211/Eppendorf/PremiumPlus/0Im4zgRHTBiqAnIewu2Mvg_thumb_267.jpg')
  ],
  eppendorf_jumbo => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305263/Eppendorf/Jumbo/yr7wyFlJQf_KmB9wnplWiA_thumb_274.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/3OP0NtCCRpSCUA2jf8b9ew_thumb_288.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/2bKM4_DZQNKYYud8PAcs_A_thumb_27c.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/YVnUzgDYSdWSd_BQsnqkaA_thumb_28d.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/mhCiEf1hQjCXcuWE6iQouw_thumb_294.jpg')
  ]
}

puts('attach photos to muehlenkamp roomtypes and community area')
attach_photos(eppendorf_photos)


eppendorf_room_descriptions = {
  eppendorf_mighty => "Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.",
  eppendorf_premium => "Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  eppendorf_premium_plus => "Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  eppendorf_jumbo => "Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m2 designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding."
}

puts('create eppendorf roomtypes descriptions')
create_descriptions(eppendorf_room_descriptions)

eppendorf_roomtypes_prices = {
  eppendorf_mighty => {'3-5 Months': 795, '6-8 Months': 745, '9+ Months': 695},
  eppendorf_mighty_plus => {'3-5 Months': 895, '6-8 Months': 845, '9+ Months': 795},
  eppendorf_premium => {'3-5 Months': 895, '6-8 Months': 845, '9+ Months': 795},
  eppendorf_premium_balcony => {'3-5 Months': 995, '6-8 Months': 945, '9+ Months': 895},
  eppendorf_premium_plus => {'3-5 Months': 995, '6-8 Months': 945, '9+ Months': 895},
  eppendorf_premium_plus_balcony => {'3-5 Months': 1_095, '6-8 Months': 1_045, '9+ Months': 995},
  eppendorf_jumbo => {'3-5 Months': 1_095, '6-8 Months': 1_045, '9+ Months': 995}
}
puts('create eppendorf roomtypes prices')
create_prices(eppendorf_roomtypes_prices)

eppendorf_roomtypes_rooms_info = {
  eppendorf_mighty => {
    "EW04" => "270 2.OG",
    "EW06" => "270a 1.OG"
    # "EW09" => "270a 2.OG",
    # "EW12" => "270a 3.OG"
  },
  eppendorf_mighty_plus => {
    "EW05" => "270"
  },
  eppendorf_premium => {
    "EW08" => "270a 1.OG",
    "EW11" => "270a 2.OG",
    "EW14" => "270a 3.OG"
  },
  eppendorf_premium_balcony => {
    "EW07" => "270a 1.OG"
    # "EW10" => "270a 2.OG",
    # "EW13" => "270a 3.OG"
  }
  eppendorf_premium_plus => {
    "EW01" => "270 2.OG"
  },
  eppendorf_premium_plus_balcony => {
    "EW02" => "270 2.OG"
  },
  eppendorf_jumbo => {
    "EW03" => "270 2.OG"
  }
}

puts('create eppendorf rooms')
create_rooms(eppendorf_roomtypes_rooms_info)


# St. Pauli

puts('create St. Pauli Project')
st_pauli = Project.create!(name: 'St. Pauli')

puts('create St. Pauli description')
st_pauli.descriptions.create!(field: 'project info index', content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in St. Pauli is just as energetic as the neighborhood.')
st_pauli.descriptions.create!(field: 'project info show', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our St. Pauli location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!")

puts('create St. Pauli Address')
st_pauli_address = st_pauli.create_address!(street: 'Detlev-Bremer-Straße', number: '2', city: 'Hamburg', zip: '20359', country: 'Germany')
puts('create St. Pauli Address description')
st_pauli_address.create_description!(field: 'address info', content: 'Our first location is located in one of the most liveable districts in Hamburg. What can you expect? Restaurants, bars and  cafes in front of your doorstep. It is your decision whether to spend a warm summer day at the Alster or meet with your roommates in our community spaces for a cold beer after work.')

puts('create St. Pauli Community Area')
st_pauli_community_area = st_pauli.community_areas.create!(name: "common space #{st_pauli.name}", size: 100)
puts('create St. Pauli Community Area description')
st_pauli_community_area.descriptions.create!(field: 'common space description', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our St. Pauli location can give you all this and more.\nOur 100m2 of community space at ground level comes with:")

puts('create St. Pauli Roomtypes')
st_pauli_mighty = st_pauli.roomtypes.create!(name: 'Mighty', size: 9)

st_pauli_premium = st_pauli.roomtypes.create!(name: 'Premium', size: 12)

st_pauli_premium_plus = st_pauli.roomtypes.create!(name: 'Premium+', size: 14)

st_pauli_jumbo = st_pauli.roomtypes.create!(name: 'Jumbo', size: 21, amount_of_people: 2)

st_pauli_photos = {
  st_pauli_community_area => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305752/St.%20Pauli/Community/ix5_os61QP2aiwbnmyTPAQ_thumb_2aa.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305755/St.%20Pauli/Community/5eh7N_I8R2uiqyjqPKnBjQ_thumb_2a6.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305761/St.%20Pauli/Community/ruAcCY62RmOSgFeuvUcOWQ_thumb_2a7.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305752/St.%20Pauli/Community/XNRI5JV4Tz2Z27qBN8gzHQ_thumb_2af.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/G2L6UQLlT_m_AsK2hG4BMQ_thumb_2ad.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/hZ1avSXdSXKWl8cHpHQxOQ_thumb_2a8.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/4CwMSQnaS3OG6nh8o2Kefw_thumb_2a9.jpg')
  ],
  st_pauli_mighty => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305779/St.%20Pauli/Mighty/9sJn0XhXQWSnNlnAY5qiog_thumb_2be.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305779/St.%20Pauli/Mighty/2JYyffPlSE2PKcvqlIeY9Q_thumb_2bd.jpg')
  ],
  st_pauli_premium => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/etyq1jicSISjC2kaGvknKw_thumb_2c3.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/YhfvXFl3R4KPIlgy36Zvcw_thumb_2bf.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/7nOOlsH5T2akODDT1PPzBw_thumb_2c2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305911/St.%20Pauli/Premium/ruC_Rtm8Sc_hiREJQOo8gA_thumb_2c4.jpg')
  ],
  st_pauli_premium_plus => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305929/St.%20Pauli/PremiumPlus/RFu4xK4rTrmChzc3VoQJlQ_thumb_2c6.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305929/St.%20Pauli/PremiumPlus/NQQT5lnTS7WCmobDw_R1hA_thumb_2c9.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305930/St.%20Pauli/PremiumPlus/zfiXMp51Q7eixCq5_P_hKg_thumb_2ca.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305932/St.%20Pauli/PremiumPlus/LweHuZn8RveZgeF6KBPNlQ_thumb_2cb.jpg')
  ],
  st_pauli_jumbo => [
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/w5Fw1W_7RdeJX1rbonPM6w_thumb_2d2.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/9gN4eFdcSM2zk1_e5LQTtg_thumb_2d1.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/NAR5Ke_FRFaRLgChuarwfA_thumb_2ce.jpg'),
    URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/DLqroMiwR8OKHdt8WI9NvQ_thumb_2cd.jpg')
  ]
}

puts('attach photos to St. Pauli roomtypes and community area')
attach_photos(st_pauli_photos)

st_pauli_room_descriptions = {
  st_pauli_mighty => "Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.",
  st_pauli_premium => "Live like a Queen! Our Premium Suites fulfill all essential needs and even provides you with private space to work within a location that is focused on community. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  st_pauli_premium_plus => "Live like a King! The Premium+ Suite is the bigger brother of our Premium Suites. With additional sqm for you and and all your thoughts. This category features a comfy double bed, side table, desk & chair, armchair, floor lamp, closet, hangers, artwork & even bedding.",
  st_pauli_jumbo => "Screw the minimalism. Your dream of your own walk-in closet becomes reality. Our Jumbo suites feature 25m2 designed for your needs with a queen-size bed, walk-in closet, desk, armchair, floor lamp, hangers, artwork and even bedding."
}

puts('create St. Pauli roomtypes descriptions')
create_descriptions(st_pauli_room_descriptions)

st_pauli_roomtypes_prices = {
  st_pauli_mighty => {'3-5 Months': 745, '6-8 Months': 695, '9+ Months': 645},
  st_pauli_premium => {'3-5 Months': 895, '6-8 Months': 845, '9+ Months': 795},
  st_pauli_premium_plus => {'3-5 Months': 995, '6-8 Months': 945, '9+ Months': 895},
  st_pauli_jumbo => {'3-5 Months': 1_095, '6-8 Months': 1_045, '9+ Months': 995}
}
puts('create St. Pauli roomtypes prices')
create_prices(st_pauli_roomtypes_prices)

st_pauli_roomtypes_rooms_info = {
  st_pauli_mighty => {
    "DB01" => "2 EG",
    "DB06" => "2 EG"
  },
  st_pauli_premium => {
    "DB04" => "2 EG"
  },
  st_pauli_premium_plus => {
    "DB02" => "2 EG",
    "DB05" => "2 EG"
  },
  st_pauli_jumbo => {
    "DB03" => "2 EG",
    "DB07" => "2 EG"
  }
}
puts('crete St. Pauli rooms')
create_rooms(st_pauli_roomtypes_rooms_info)


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

amenities.each do |title, file|
  a = Amenity.new(title: title)
  a.photo.attach(io: handle_string_io_as_file(file), filename: "#{title.gsub(' ', '_')}.png", content_type: 'image/png')
  a.save
end
