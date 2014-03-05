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

User.create(first_name: "George",
            last_name: "Washington",
            phone: "201-201-2010",
            email: "georgewashington@valleyforge.com",
            password: "password",
            password_confirmation: "password")

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
    day = rand(3..9)
    space.reservations.create(renter_id: rand(1..20),
               start_time: DateTime.new(2014,3,day,start_hour,0,0),
               end_time: DateTime.new(2014,3,day,end_hour,0,0),
               num_people: rand(1..10),
               intended_use: Faker::Lorem.paragraph
            )
  end

  5.times do
    start_hour = rand(13..21)
    end_hour = start_hour + 2
    day = rand(10..16)
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
                    start_time: DateTime.new(1011, 3, 3, 9, 0, 0, '-6'),
                    end_time: DateTime.new(1011, 3, 3, 17, 0, 0, '-6'),
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

#-----------------------Seed Payments----------------------------------------------
# Payment.create(creator_id: 1, secret_api_key: "sk_test_mC0xJbEJjQn6fTFFXbF1iY0H", publishable_api_key: "pk_test_pnsJYKvwITr1blAJDXU8Yjv7", refresh_token: "rt_3aBCE7XsHeyoi5yqjCXndALQ6JIKltGTHH11KuPS0KBdUehx", stripe_user_id: "acct_103aBC2tZaA3CnwC")
# Payment.create(creator_id: 2, secret_api_key: "sk_test_bZj3yCI2T3bzV85XRzvzRzFl", publishable_api_key: "pk_test_GoDAjXI0FKBPyEUuT5qmNGbv", refresh_token: "rt_3aOB4oZsceUP5AVIBQ4hmYHeo715KjVrm9iGhmFVzDqLplDf", stripe_user_id: "acct_103Zex26RoKDB1cW")
Payment.create(creator_id: 1, secret_api_key: "sk_test_1bDMZ95bU3Xa3EdqVVkv5o1m", publishable_api_key: "pk_test_caQ4h6AFl9aE97UbMmqkqVSV", refresh_token: "rt_3c0nv6uiCGmripb3LHPpx4UF6TEpYl8bcO9gHpqcKMFs6skn...", stripe_user_id: "acct_103aWM2TTcvmqKrL", created_at: "2014-03-05 21:41:50", updated_at: "2014-03-05 21:41:50")
Payment.create(creator_id: 2, secret_api_key: "sk_test_1bDMZ95bU3Xa3EdqVVkv5o1m", publishable_api_key: "pk_test_caQ4h6AFl9aE97UbMmqkqVSV", refresh_token: "rt_3c0nv6uiCGmripb3LHPpx4UF6TEpYl8bcO9gHpqcKMFs6skn...", stripe_user_id: "acct_103aWM2TTcvmqKrL", created_at: "2014-03-05 21:41:50", updated_at: "2014-03-05 21:41:50")

#----------------------Seed Images___________________________________________________

IMG_ARRAY = [ "https://s3.amazonaws.com/rentspaces/uploads/1393785811893-n0yau8vrclo0qkt9-4c20bbe51412da2e07a6b3b216b998f7/download.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393786143147-0esjp61262zqia4i-54f4514197f477b174bab6c11a466241/dl2.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393786148919-dxo28k26efef80k9-54f4514197f477b174bab6c11a466241/tumblr_l00r7wG6xt1qzoh1b.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393786238790-gwip961oje3a0pb9-4ea79c2f649e7b192497a0571ab54669/south_space_large.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393786528482-pj9aezsu8qfflxr-dc20b9d73fdc6e87bab2b3935f8d2e2c/image_view.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393787711815-9ul6lz3r6gsnhfr-7f0797ab436b8098227f8d3abcf09c82/Original-Empty-Room-Resized.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393787719281-qbjt34jv4bpm0a4i-7f0797ab436b8098227f8d3abcf09c82/I%2Bbelieve%2Bit%2Bwould%2Bbe%2Bsomething%2Blike%2Bthis%2B_93d4703edf64676729594cc837f99582.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393790193377-49930nsk2urtfbt9-c423f8f12cc74fb17dc49585590f0ca5/177904033_80ebca4fd3_o.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393791233711-tqnasgt4sjg7gb9-1e54f0261d5ad5fbd9d89db420efef14/dance_space.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b/images.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8/1251910935-yd-a-528x343.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393793556754-hfngcnc56gmygb9-e4a45dc51eacfeb964193f208e908e2b/Rosana-empty-studio.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8/1251910935-yd-a-528x343.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393857056084-zvalncahh6ywrk9-a57e6ea588502e0309282eaf9698e8a5/mms_picture+copy.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393857071031-13nwxwzd1ln89f6r-a57e6ea588502e0309282eaf9698e8a5/mms_picture.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393861299877-44fahvii1j68ncdi-73c797abf11bbd6d22cfba3f2e4a4468/mms_picture+(1)+copy.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393861381975-bddxfzkxfyxh6w29-e876072773b4cce0fc818245fad93b75/mms_picture+(1).jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393861452673-r7pjok8clult0529-c4698ce628f9862e1d1e695d92055ea7/mms_picture+(2).jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393874804694-b8rgrf4rf3d9ggb9-62a79ae1c92acddfd4450b3883a66465/sanfran.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b/images.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393794116931-bkpqo7pvez2rzfr-051bd9a4f9b4afe9b19fa26c4c4d15e8%2FRosana-empty-studio.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8%2F1251910935-yd-a-528x343.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b%2Fimages.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads/1393793556754-hfngcnc56gmygb9-e4a45dc51eacfeb964193f208e908e2b/Rosana-empty-studio.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393786528482-pj9aezsu8qfflxr-dc20b9d73fdc6e87bab2b3935f8d2e2c%2Fimage_view.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393786238790-gwip961oje3a0pb9-4ea79c2f649e7b192497a0571ab54669%2Fsouth_space_large.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393786143147-0esjp61262zqia4i-54f4514197f477b174bab6c11a466241%2Fdl2.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393786148919-dxo28k26efef80k9-54f4514197f477b174bab6c11a466241%2Ftumblr_l00r7wG6xt1qzoh1b.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393785811893-n0yau8vrclo0qkt9-4c20bbe51412da2e07a6b3b216b998f7%2Fdownload.jpeg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393787711815-9ul6lz3r6gsnhfr-7f0797ab436b8098227f8d3abcf09c82%2FOriginal-Empty-Room-Resized.jpg",
              "https://s3.amazonaws.com/rentspaces/uploads%2F1393787719281-qbjt34jv4bpm0a4i-7f0797ab436b8098227f8d3abcf09c82%2FI%2Bbelieve%2Bit%2Bwould%2Bbe%2Bsomething%2Blike%2Bthis%2B_93d4703edf64676729594cc837f99582.jpg"
            ]

Space.all.each do |space|
  rand(2..4).times do
    Photo.create(space: space, url: IMG_ARRAY.sample)
  end
end




# "https://s3.amazonaws.com/rentspaces/uploads/1393785811893-n0yau8vrclo0qkt9-4c20bbe51412da2e07a6b3b216b998f7/download.jpeg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393786143147-0esjp61262zqia4i-54f4514197f477b174bab6c11a466241/dl2.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393786148919-dxo28k26efef80k9-54f4514197f477b174bab6c11a466241/tumblr_l00r7wG6xt1qzoh1b.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393786238790-gwip961oje3a0pb9-4ea79c2f649e7b192497a0571ab54669/south_space_large.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393786528482-pj9aezsu8qfflxr-dc20b9d73fdc6e87bab2b3935f8d2e2c/image_view.jpeg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393787711815-9ul6lz3r6gsnhfr-7f0797ab436b8098227f8d3abcf09c82/Original-Empty-Room-Resized.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393787719281-qbjt34jv4bpm0a4i-7f0797ab436b8098227f8d3abcf09c82/I%2Bbelieve%2Bit%2Bwould%2Bbe%2Bsomething%2Blike%2Bthis%2B_93d4703edf64676729594cc837f99582.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393790193377-49930nsk2urtfbt9-c423f8f12cc74fb17dc49585590f0ca5/177904033_80ebca4fd3_o.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393791233711-tqnasgt4sjg7gb9-1e54f0261d5ad5fbd9d89db420efef14/dance_space.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393793550915-avlx57x6sguy2e29-e4a45dc51eacfeb964193f208e908e2b/images.jpeg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8/1251910935-yd-a-528x343.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393793556754-hfngcnc56gmygb9-e4a45dc51eacfeb964193f208e908e2b/Rosana-empty-studio.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393794127242-ugv41c3owv2yy14i-051bd9a4f9b4afe9b19fa26c4c4d15e8/1251910935-yd-a-528x343.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393857056084-zvalncahh6ywrk9-a57e6ea588502e0309282eaf9698e8a5/mms_picture+copy.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393857071031-13nwxwzd1ln89f6r-a57e6ea588502e0309282eaf9698e8a5/mms_picture.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393861299877-44fahvii1j68ncdi-73c797abf11bbd6d22cfba3f2e4a4468/mms_picture+(1)+copy.jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393861381975-bddxfzkxfyxh6w29-e876072773b4cce0fc818245fad93b75/mms_picture+(1).jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393861452673-r7pjok8clult0529-c4698ce628f9862e1d1e695d92055ea7/mms_picture+(2).jpg",
# "https://s3.amazonaws.com/rentspaces/uploads/1393874804694-b8rgrf4rf3d9ggb9-62a79ae1c92acddfd4450b3883a66465/sanfran.jpg"
#25


















