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

#-------------------------Seed Admins-----------------------------------------------

Admin.create(administrator_id: 3,
			 space_id: 1)
Admin.create(administrator_id: 4,
			 space_id: 2)

#------------------------Seed Reservations------------------------------------------

Space.all.each do |space|
  5.times do
    start_hour = rand(13..21)
    end_hour = start_hour + 2
    day = rand(3..10)
    space.reservations.create(renter_id: rand(1..20),
               start_time: DateTime.new(2014,3,day,start_hour,0,0),
               end_time: DateTime.new(2014,3,day,end_hour,0,0),
               num_people: rand(1..10),
               intended_use: Faker::Lorem.paragraph
            )
  end
end

#------------------------Seed Availabilities---------------------------------------

Space.all.each do |space|
  (1..5).each do |day|
    space.availabilities.create(space_id: space.id,
                    start_time: DateTime.new(1011, 3, 3, 9, 0, 0),
                    end_time: DateTime.new(1011, 3, 3, 17, 0, 0),
                    day: day
                  )
  end
end

#-----------------------Seed SpaceUses----------------------------------------------

20.times do
  SpaceUse.create(use_id: rand(1..14),
  				  space_id: rand(1..10),
				)
end

# here is some seed data, you can upload photos and the spaces#add_photo route will post its url in console, cheers!
# https://s3.amazonaws.com/rentspaces/uploads%2F1393786528482-pj9aezsu8qfflxr-dc20b9d73fdc6e87bab2b3935f8d2e2c%2Fimage_view.jpeg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393786238790-gwip961oje3a0pb9-4ea79c2f649e7b192497a0571ab54669%2Fsouth_space_large.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393786143147-0esjp61262zqia4i-54f4514197f477b174bab6c11a466241%2Fdl2.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393786148919-dxo28k26efef80k9-54f4514197f477b174bab6c11a466241%2Ftumblr_l00r7wG6xt1qzoh1b.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393785811893-n0yau8vrclo0qkt9-4c20bbe51412da2e07a6b3b216b998f7%2Fdownload.jpeg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393787711815-9ul6lz3r6gsnhfr-7f0797ab436b8098227f8d3abcf09c82%2FOriginal-Empty-Room-Resized.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393787719281-qbjt34jv4bpm0a4i-7f0797ab436b8098227f8d3abcf09c82%2FI%2Bbelieve%2Bit%2Bwould%2Bbe%2Bsomething%2Blike%2Bthis%2B_93d4703edf64676729594cc837f99582.jpg

#-----------------------Seed Payments----------------------------------------------
Payment.create(creator_id: 1, secret_api_key: "sk_test_mC0xJbEJjQn6fTFFXbF1iY0H", publishable_api_key: "pk_test_pnsJYKvwITr1blAJDXU8Yjv7", refresh_token: "rt_3aBCE7XsHeyoi5yqjCXndALQ6JIKltGTHH11KuPS0KBdUehx", stripe_user_id: "acct_103aBC2tZaA3CnwC")
Payment.create(creator_id: 2, secret_api_key: "sk_test_bZj3yCI2T3bzV85XRzvzRzFl", publishable_api_key: "pk_test_GoDAjXI0FKBPyEUuT5qmNGbv", refresh_token: "rt_3aOB4oZsceUP5AVIBQ4hmYHeo715KjVrm9iGhmFVzDqLplDf", stripe_user_id: "acct_103Zex26RoKDB1cW")


# https://s3.amazonaws.com/rentspaces/uploads%2F1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b%2Fimages.jpeg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393794116931-bkpqo7pvez2rzfr-051bd9a4f9b4afe9b19fa26c4c4d15e8%2FRosana-empty-studio.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8%2F1251910935-yd-a-528x343.jpg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b%2Fimages.jpeg
# https://s3.amazonaws.com/rentspaces/uploads%2F1393793556754-hfngcnc56gmygb9-e4a45dc51eacfeb964193f208e908e2b%2FRosana-empty-studio.jpg







