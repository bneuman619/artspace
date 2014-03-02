class Availability < ActiveRecord::Base
  belongs_to :space
  validate :check_overlap

  def check_overlap
    availabilities = self.space.availabilities
    overlaps = availabilities.any? do |availability|
      self.start_time.between?(availability.start_time, availability.end_time) ||
      self.end_time.between?(availability.start_time, availability.end_time)
    end

    if overlaps
       self.errors[:time_range] << "Availability can not overlap with other availabilities"
    end
  end
end
