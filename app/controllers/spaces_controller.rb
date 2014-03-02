class SpacesController < ApplicationController
  def index
    @spaces = Space.scoped
    @spaces = @spaces.title(params[:title]) if params[:title].present?
    @spaces = @spaces.rate_less(params[:rate]) if params[:rate].present?
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
      # redirect_to manage_path(session[:current_user_id])
      # redirect_to manage_path(session[:current_user_id])
      
      # Redirect to space availability
      redirect_to new_space_availability_path(@space)

      # Add stripe to process flow when creating a space
      # redirect_to new_payment_path
      
    else
      #raise some sort of error and send the creator back to the form
    end
  end

  def show
    @space = Space.find(params[:id])
    @calendar_info = calendar_info(@space).to_json
    @publishable_key = @space.creator.publishable_key
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    # @space = params
    @use_ids = params[:space][:use_ids] ||= []
    space = Space.find(params[:id])
    space.update(space_params)
    space.space_uses.clear
    @use_ids.each do |u|
      SpaceUse.create(space_id: space.id, use_id: u.to_i)
    end
    # redirect_to manage_path(current_user.id)
    redirect_to edit_availabilities_path(space)
  end

  def destroy
    @space = Space.find(params[:id])
    # remove availability of space
    # if space has future reservations
      # 
    # otherwise delete space and all associated data OR set a flag to stop display

    # @space.destroy
    # redirect_to manage_path(current_user.id)
  end

  def add_photo #temporary testing route, delete me
    params["url"]
    redirect_to new_space_path
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
  today = DateTime.now
  this_monday = today - (today.wday - 1)
  space.availabilities.all.collect do |availability|
  {"start" => DateTime.new(this_monday.year, this_monday.month, this_monday.day, availability.start_time.hour, availability.start_time.strftime("%m").to_i) + (availability.day - 1).day,
   "end" => DateTime.new(this_monday.year, this_monday.month, this_monday.day, availability.end_time.hour, availability.end_time.strftime("%m").to_i) + (availability.day - 1).day,
   "title" => ""}
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



