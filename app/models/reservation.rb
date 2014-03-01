class Reservation < ActiveRecord::Base
  belongs_to :renter, class_name: "User"
  belongs_to :space

  def length_in_hours
    (self.end_time - self.start_time) / 1.hour
  end
end
