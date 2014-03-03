class Availability < ActiveRecord::Base
  belongs_to :space
  # validate :check_overlap

  def check_overlap
    availabilities = self.space.availabilities
    overlaps = availabilities.select do |availability|
      self.start_time.between?(availability.start_time, availability.end_time) ||
      self.end_time.between?(availability.start_time, availability.end_time)
    end

    unless overlaps.empty?
       overlap_info = overlaps.reduce("") do |string, overlap|
         string += overlap.to_s + "      "
       end
       self.errors[:time_range] << overlap_info
    end
  end
end
