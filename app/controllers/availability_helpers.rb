module AvailabilityHelpers
  def parse_availability(availability)
    {start_time: parse_availability_time(DateTime.parse(availability[:start])),
    end_time: parse_availability_time(DateTime.parse(availability[:end])),
    day: DateTime.parse(availability[:start]).wday}
  end

  def parse_availability_time(time)
    DateTime.new(2000, 01, 01, time.hour, time.minute, time.second, '-6')
  end
end
