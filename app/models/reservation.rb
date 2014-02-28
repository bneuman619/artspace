class Reservation < ActiveRecord::Base
  belongs_to :renter, class_name: "User"
  belongs_to :space
end
