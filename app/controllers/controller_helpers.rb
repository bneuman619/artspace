module ControllerHelpers
  def parse_availability(availability)
    {start_time: parse_availability_time(DateTime.parse(availability[:start])),
    end_time: parse_availability_time(DateTime.parse(availability[:end])),
    day: DateTime.parse(availability[:start]).wday}
  end

  def parse_availability_time(time)
    DateTime.new(2000, 01, 01, time.hour, time.minute, time.second, '-6')
  end

  def calendar_info(space)
    {openings: get_openings_for_four_weeks(week_openings(DateTime.now, space)),
     reservations: get_reservations(space)
    }
  end

  def get_openings_for_four_weeks(one_week_openings)
    openings = []
    (1..3).each do |week|
      one_week_openings.each do |opening|
        openings << {"start" => opening["start"] + week.week - 1.hour,
         "end" => opening["end"] + week.week - 1.hour,
         "title" => opening["title"]
        }
      end
    end
    one_week_openings + openings
  end

  def week_openings(day, space)
    sunday = day - day.wday.day
    space.availabilities.all.collect do |availability|
      {"start" => convert_availability_date(sunday, availability.start_time, availability.day, false),
       "end" => convert_availability_date(sunday, availability.end_time, availability.day, true),
       "title" => "",
       "day" => availability.day,
       "id" => availability.id}
    end
  end

  def convert_availability_date(sunday, availability_dt, day_num, end_time)
    adjusted_availability = if availability_dt.hour < 6
      availability_dt + 18.hour
    elsif availability_dt.hour == 6 && end_time
      availability_dt + 18.hour - 1.minute
    else
      availability_dt - 6.hour
    end

    DateTime.new(sunday.year, sunday.month, sunday.day, adjusted_availability.hour, adjusted_availability.min, 0, '-6') + day_num.day
  end

  def get_reservations(space)
    space.reservations.all.collect do |reservation|
      {"id" => reservation.id,
       "start" => reservation.start_time,
       "end" => reservation.end_time,
        "title" => reservation.renter.first_name + reservation.renter.last_name}
    end
  end

end
