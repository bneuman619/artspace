class AvailabilitiesController < ApplicationController
  def new
  end

  def create
    space = Space.find(params[:spaceId])
    availability_data = params["data"]
    availabilities = availability_data.values.collect do |availability|
      space.availabilities.create(
        parse_availability(availability))
    end

    if availabilities.any?(&:invalid?)
      space.availabilities.destroy_all
      render json: {status: 'error', message: "Validation error with availabilities", availablities: availabilities}.to_json
    else
      render json: {status: 'success'}.to_json
    end
  end

  def edit
    space = Space.find(params[:space_id])
    @user_id = current_user.id
    @calendar_info = get_openings(space).to_json
  end

  def update
    space = Space.find(params[:spaceId])
    old_availabilities = space.availabilities.destroy_all

    availability_data = params["data"]
    availabilities = availability_data.values.collect do |availability|
      space.availabilities.create(
        parse_availability(availability))
    end

    if availabilities.any?(&:invalid?)
      space.availabilities.destroy_all
      old_availabilities.each { |avail| space.availabilities.create(avail.attributes) }
      render json: {status: 'error', message: "Validation error with availabilities"}.to_json
    else
      render json: {status: 'success'}.to_json
    end
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

def get_openings(space)
  today = DateTime.now
  this_monday = today - (today.wday - 1)
  space.availabilities.all.collect do |availability|
  {"start" => DateTime.new(this_monday.year, this_monday.month, this_monday.day, availability.start_time.hour, availability.start_time.strftime("%m").to_i) + (availability.day - 1).day,
   "end" => DateTime.new(this_monday.year, this_monday.month, this_monday.day, availability.end_time.hour, availability.end_time.strftime("%m").to_i) + (availability.day - 1).day,
   "title" => ""}
  end
end



