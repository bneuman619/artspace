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
# also, the .env.local needs my keys!, email me and I will share you my google drive that has the keys.
# https://s3.amazonaws.com/rentspaces/uploads/1393634155457-9tn5lleq5sjug14i-da7febbe96331e606efac97fbbc24fef/mms_picture+(1).jpg?AWSAccessKeyId=ASIAI5T4P5OB4PR5JJEQ&Expires=1393634484&Signature=DUWGxd8SrgpQkSSw%2B4JHHIR4jbU%3D&x-amz-security-token=AQoDYXdzEML//////////wEagAJU8Af/6juOD35xVKWCHiOSQ1miT8ZcnK9t7Fqrr3oFaMGb/dgjbIYEpouJJH4L9ykQD75z5iTM4%2BVqDPcUn6ZnPFs0WlqdYdRb7Tdm7mTMdjHaEr8gJjv9vMTqf1HZl5a92j06cW9H9phfv85G/bbRdGy716Ko%2Bz/jAGSZFsFfT8J4b%2BG/ABCBQInM0P88Tc3FBGgceXBjmToz7CiyPp2PwQjGlrm9GmXTJP6nq6LIVIqDh9ZjK2lyUaXNDSiStHze9GhOR9NVJcnLNhBaEAUWiuvwmGeGvBlzIAC/eo/CqFF4KX38Qoejl6J4vi977qaA6K7LoFf0zwAj98JL0PtgINOCw5gF
# https://s3.amazonaws.com/rentspaces/uploads/1393634147511-kkpnvs1ww7wlv7vi-da7febbe96331e606efac97fbbc24fef/mms_picture+copy.jpg?AWSAccessKeyId=ASIAI5T4P5OB4PR5JJEQ&Expires=1393634511&Signature=JtqW0rqnPxFbgd938N4JwPdpASs%3D&x-amz-security-token=AQoDYXdzEML//////////wEagAJU8Af/6juOD35xVKWCHiOSQ1miT8ZcnK9t7Fqrr3oFaMGb/dgjbIYEpouJJH4L9ykQD75z5iTM4%2BVqDPcUn6ZnPFs0WlqdYdRb7Tdm7mTMdjHaEr8gJjv9vMTqf1HZl5a92j06cW9H9phfv85G/bbRdGy716Ko%2Bz/jAGSZFsFfT8J4b%2BG/ABCBQInM0P88Tc3FBGgceXBjmToz7CiyPp2PwQjGlrm9GmXTJP6nq6LIVIqDh9ZjK2lyUaXNDSiStHze9GhOR9NVJcnLNhBaEAUWiuvwmGeGvBlzIAC/eo/CqFF4KX38Qoejl6J4vi977qaA6K7LoFf0zwAj98JL0PtgINOCw5gF
# https://s3.amazonaws.com/rentspaces/uploads/1393633681768-tgcz56st91s2lnmi-da7febbe96331e606efac97fbbc24fef/mms_picture+(1).jpg?AWSAccessKeyId=ASIAI5T4P5OB4PR5JJEQ&Expires=1393634525&Signature=Xwy%2BwphWTAM1f5pUW%2BrXrRtupGE%3D&x-amz-security-token=AQoDYXdzEML//////////wEagAJU8Af/6juOD35xVKWCHiOSQ1miT8ZcnK9t7Fqrr3oFaMGb/dgjbIYEpouJJH4L9ykQD75z5iTM4%2BVqDPcUn6ZnPFs0WlqdYdRb7Tdm7mTMdjHaEr8gJjv9vMTqf1HZl5a92j06cW9H9phfv85G/bbRdGy716Ko%2Bz/jAGSZFsFfT8J4b%2BG/ABCBQInM0P88Tc3FBGgceXBjmToz7CiyPp2PwQjGlrm9GmXTJP6nq6LIVIqDh9ZjK2lyUaXNDSiStHze9GhOR9NVJcnLNhBaEAUWiuvwmGeGvBlzIAC/eo/CqFF4KX38Qoejl6J4vi977qaA6K7LoFf0zwAj98JL0PtgINOCw5gF
# https://s3.amazonaws.com/rentspaces/uploads/1393633625786-rr5xa8suvykl0udi-c43fd35a4105a9482ca5f6e69863edc4/mms_picture+(2).jpg?AWSAccessKeyId=ASIAI5T4P5OB4PR5JJEQ&Expires=1393634543&Signature=HOr4/cWLglzkUrQ/g8l%2BiMVgzYY%3D&x-amz-security-token=AQoDYXdzEML//////////wEagAJU8Af/6juOD35xVKWCHiOSQ1miT8ZcnK9t7Fqrr3oFaMGb/dgjbIYEpouJJH4L9ykQD75z5iTM4%2BVqDPcUn6ZnPFs0WlqdYdRb7Tdm7mTMdjHaEr8gJjv9vMTqf1HZl5a92j06cW9H9phfv85G/bbRdGy716Ko%2Bz/jAGSZFsFfT8J4b%2BG/ABCBQInM0P88Tc3FBGgceXBjmToz7CiyPp2PwQjGlrm9GmXTJP6nq6LIVIqDh9ZjK2lyUaXNDSiStHze9GhOR9NVJcnLNhBaEAUWiuvwmGeGvBlzIAC/eo/CqFF4KX38Qoejl6J4vi977qaA6K7LoFf0zwAj98JL0PtgINOCw5gF
# https://s3.amazonaws.com/rentspaces/uploads/1393632926299-iyfjjlfl91zwipb9-9c680df8f63b16cead1273b97b413c62/mms_picture+(1).jpg?AWSAccessKeyId=ASIAI5T4P5OB4PR5JJEQ&Expires=1393634558&Signature=fBrBXT5aczzAguXty1CEN7MC4Lk%3D&x-amz-security-token=AQoDYXdzEML//////////wEagAJU8Af/6juOD35xVKWCHiOSQ1miT8ZcnK9t7Fqrr3oFaMGb/dgjbIYEpouJJH4L9ykQD75z5iTM4%2BVqDPcUn6ZnPFs0WlqdYdRb7Tdm7mTMdjHaEr8gJjv9vMTqf1HZl5a92j06cW9H9phfv85G/bbRdGy716Ko%2Bz/jAGSZFsFfT8J4b%2BG/ABCBQInM0P88Tc3FBGgceXBjmToz7CiyPp2PwQjGlrm9GmXTJP6nq6LIVIqDh9ZjK2lyUaXNDSiStHze9GhOR9NVJcnLNhBaEAUWiuvwmGeGvBlzIAC/eo/CqFF4KX38Qoejl6J4vi977qaA6K7LoFf0zwAj98JL0PtgINOCw5gF


#-----------------------Seed Payments----------------------------------------------
Payment.create(creator_id: 1, secret_api_key: "sk_test_mC0xJbEJjQn6fTFFXbF1iY0H", publishable_api_key: "pk_test_pnsJYKvwITr1blAJDXU8Yjv7", refresh_token: "rt_3aBCE7XsHeyoi5yqjCXndALQ6JIKltGTHH11KuPS0KBdUehx", stripe_user_id: "acct_103aBC2tZaA3CnwC")
Payment.create(creator_id: 2, secret_api_key: "sk_test_bZj3yCI2T3bzV85XRzvzRzFl", publishable_api_key: "pk_test_GoDAjXI0FKBPyEUuT5qmNGbv", refresh_token: "rt_3aOB4oZsceUP5AVIBQ4hmYHeo715KjVrm9iGhmFVzDqLplDf", stripe_user_id: "acct_103Zex26RoKDB1cW")













