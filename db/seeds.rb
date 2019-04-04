# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(email: 'fritz@stacey-living.de', password: 'FritzMeyer',first_name: 'Fritz', last_name: 'Meyer', phone_code: '+49', phone: '0173755772', date_of_birth: '04-02-2000', job: 'Developer', move_in_date: '01-07-2019', duration_of_stay: '3 Months', amount_of_people: 'Single', description: 'Glad to be part of STACEY', admin: true, applicant: false)
User.create!(email: 'matteo@stacey-living.de', password: 'MatteoKreidler', first_name: 'Matteo', last_name: 'Kreidler', phone_code: '+49', phone: '09876543', date_of_birth: '20-08-1996', job: 'Entrepreneur', move_in_date: '01-07-2019', duration_of_stay: '3 Months', amount_of_people: 'Single', description: 'Glad to be part of STACEY', admin: true, applicant: false)
User.create!(email: 'applicant@applicant.de', password: 'Applicant', first_name: 'Applicant', last_name: 'ApplicantsLast', phone_code: '+49', phone: '0987654332', date_of_birth: '20-08-1996', job: 'Applicant', move_in_date: '01-07-2019', duration_of_stay: '3 Months', amount_of_people: 'Single', description: 'Glad to be part of STACEY', admin: false, applicant: true)

Flat.create!(street: 'Eppendorfer Weg 80', zipcode: 23421, city: 'Hamburg', project_name: 'Eppendorf')

Room.create(price: [800, 900, 1000], art_of_room: 'Basic Suite', balcony: false, room_size: '10', deposit: [1000, 1200, 1400], flat_id: 1, user_id: User.first )
Room.create(price: [850, 800, 800], art_of_room: 'Basic Suite', balcony: true, room_size: '10', deposit: [1000, 1200, 1400], flat_id: 1, user_id: User.first )
Room.create(price: [900, 900, 1000], art_of_room: 'Premium Suite', balcony: false, room_size: '15', deposit: [1000, 1200, 1400], flat_id: 1, user_id: User.first )
Room.create(price: [950, 900, 1000], art_of_room: 'Premium Suite', balcony: true, room_size: '15', deposit: [1000, 1200, 1400], flat_id: 1, user_id: User.first )

# counter = 1;

# 20.times do
#   counter = counter + 1
#   User.create!(email: "test#{counter}@test.de", first_name: 'Test', last_name: 'Test', phone: '015234513111', date_of_birth: '16-08-2996', job: 'Entrepreneur', move_in_date: '04-04-2019', duration_of_stay: '3 Months', admin: false, amount_of_people: 'Single', password: 'TestTest')
# end
