class SpacesController < ApplicationController
  def index
    @spaces = Space.search(params[:search])
  end

  def new
  end

  def create
  end

  def show
    space = Space.find(params[:id])
    @calendar_info = calendar_info(space).to_json
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

def calendar_info(space)
  {openings: get_openings(space),
   reservations: get_reservations(space)
  }
end

def get_openings(space)
  space.availabilities.all.collect do |availability|
  {"start" => DateTime.new(2014, 2, 24, availability.start_time.hour, availability.start_time.strftime("%m").to_i) + (availability.day - 1).day,
   "end" => DateTime.new(2014, 2, 24, availability.end_time.hour, availability.end_time.strftime("%m").to_i) + (availability.day - 1).day}
  end
end

def get_reservations(space)
  space.reservations.all.collect do |reservation|
    {"id" => reservation.id,
     "start" => reservation.start_time,
     "end" => reservation.end_time,
      "title" => reservation.renter.first_name + reservation.renter.last_name}
  end
end
