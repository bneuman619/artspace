class SpacesController < ApplicationController
  def index
    @spaces = Space.search(params[:search])
  end

  def new
    @space = Space.new
  end

  def create
    @use_ids = params[:space][:use_ids] ||= []
    @space = Space.new(space_params)
    @space.creator_id = session[:current_user_id]
    if @space.save
      @use_ids.each do |u|
        SpaceUse.create(space_id: @space.id, use_id: u.to_i)
      end
      redirect_to manage_path(session[:current_user_id])
    else
      #raise some sort of error and send the creator back to the form
    end
  end

  def show
    space = Space.find(params[:id])
    @calendar_info = calendar_info(space).to_json
    # @publishable_key = space.creator.publishable_key
    # @email = current_user.email
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def add_photo #temporary testing route, delete me
    puts params.inspect
  end

  private

  def space_params
    params.require(:space).permit(:title, :description, :dimensions, 
                                  :ammenities, :rate, :address, 
                                  :city, :state, :zipcode, :email,
                                  :phone)
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



