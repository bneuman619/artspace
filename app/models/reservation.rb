class Reservation < ActiveRecord::Base
  belongs_to :renter, class_name: "User", foreign_key: "renter_id"
  belongs_to :space
end
