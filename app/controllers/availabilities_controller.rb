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
      render json: {status: 'error', message: "Validation error with availabilities"}.to_json
    else
      render json: {status: 'success'}.to_json
    end
  end

  def edit
    space = Space.find(params[:space_id])
    if !session[:current_user_id]
      render "welcome/index"
    elsif session[:current_user_id] != space.creator_id
      redirect_to user_path(current_user.id)
    else
      @user_id = current_user.id
      @calendar_info = week_openings(DateTime.now, space).to_json
    end
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
  DateTime.new(2000, 01, 01, time.hour, time.minute, time.second, '-6')
end

def get_openings(space)
  today = DateTime.now
  this_sunday = today - today.wday
  space.availabilities.all.collect do |availability|
    start_time = availability.start_time - 6.hour
    end_time = availability.end_time - 6.hour
  {"start" => DateTime.new(this_sunday.year, this_sunday.month, this_sunday.day, start_time.hour, start_time.min, 0,'-6') + availability.day.day,
   "end" => DateTime.new(this_sunday.year, this_sunday.month, this_sunday.day, end_time.hour, end_time.min, 0, '-6') + availability.day.day,
   "title" => ""}
  end
end

# def convert_availability_date(sunday, availability_dt, day_num)
#   if availability_dt.hour <= 6
#     DateTime.new(sunday.year, sunday.month, sunday.day + 1, availability.dt.hour, availability.dt.min, 0, '-6') + day_num.day - 6.hour
#   else
#     DateTime.new(sunday.year, sunday.month, sunday.day, availability.dt.hour, availability.dt.min, 0, '-6') + day_num.day - 6.hour
#   end
# end


