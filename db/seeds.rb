# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'


#------------------------------------Seed Uses------------------------------------
Use.create(category: "dance")
Use.create(category: "audio")
Use.create(category: "studio art")
Use.create(category: "theater")
Use.create(category: "rehearsal")
Use.create(category: "performance")
Use.create(category: "class")
Use.create(category: "audition")
Use.create(category: "photoshoot")
Use.create(category: "video")
Use.create(category: "exhibition")
Use.create(category: "reading")
Use.create(category: "screening")
Use.create(category: "any")

#-----------------------------------Seed Users-------------------------------------

20.times do
  User.create(first_name: Faker::Name.first_name,
  			  last_name: Faker::Name.last_name,
  			  phone: Faker::PhoneNumber.phone_number,
  			  email: Faker::Internet.email,
  			  password: "password",
  			  password_confirmation: "password"
  			)
end

#------------------------------------Seed Spaces---------------------------------

5.times do
  Space.create(creator_id: 1,
  			  title: Faker::Company.name,
  			  description: Faker::Lorem.paragraph, 
  			  dimensions: "8 ft by 100 ft",
  			  ammenities: Faker::Lorem.paragraph,
  			  rate: 20.00,
  			  address: Faker::Address.street_address,
  			  city: "Chicago",
  			  state: "IL",
  			  zipcode: Faker::Address.zip_code,
  			  email: Faker::Internet.email,
  			  phone: Faker::PhoneNumber.phone_number)
end
5.times do
  Space.create(creator_id: 2,
  			  title: Faker::Company.name,
  			  description: Faker::Lorem.paragraph, 
  			  dimensions: "20 ft by 60 ft",
  			  ammenities: Faker::Lorem.paragraph,
  			  rate: 10.00,
  			  address: Faker::Address.street_address,
  			  city: "Chicago",
  			  state: "IL",
  			  zipcode: Faker::Address.zip_code,
  			  email: Faker::Internet.email,
  			  phone: Faker::PhoneNumber.phone_number)
end























