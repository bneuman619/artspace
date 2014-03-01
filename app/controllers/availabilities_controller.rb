class AvailabilitiesController < ApplicationController
  def new
  end

  def create
    @space = Space.find(params[:spaceId])
    availability_data = params["data"]
    availabilities = availability_data.values.collect do |availability|
      @space.availabilities.create(
        parse_availability(availability))
    end

    render json: "a response".to_json
  end

  def edit
  end

  def update 
  end
end

def parse_availability(availability)
  {start_time: parse_availability_time(DateTime.parse(availability[:start])),
  end_time: parse_availability_time(DateTime.parse(availability[:end])),
  day: DateTime.parse(availability[:start]).wday}
end

def parse_availability_time(time)
  DateTime.new(2000, 01, 01, time.hour, time.minute, time.second)
end
