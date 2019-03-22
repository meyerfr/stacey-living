# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

counter = 1;

20.times do
  counter = counter + 1
  User.create!(email: "test#{counter}@test.de", first_name: 'Test', last_name: 'Test', phone: '015234513111', date_of_birth: '16-08-2996', job: 'Entrepreneur', move_in_date: '04-04-2019', duration_of_stay: '3 Months', admin: false, amount_of_people: 'Single', password: 'TestTest')
end
