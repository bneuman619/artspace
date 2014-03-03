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

    if params["pic_url"]
      params["pic_url"].split(',').each do |url|
        Photo.create(space: @space, url: url)
      end
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
    space.active = 1
    space.save
    # redirect_to manage_path(current_user.id)
    redirect_to manage_path(session[:current_user_id])
  end

  def destroy
    space = Space.find(params[:id])
    # remove availability of space
    space.availabilities.clear
    # mark space inactive
    space.active = 0
    space.save
    redirect_to manage_path(current_user.id)
  end

  def add_photo #temporary testing route
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
  get_openings_for_four_weeks(week_openings(DateTime.now, space))
end

def get_openings_for_four_weeks(one_week_openings)
  openings = []
  (1..3).each do |week|
    one_week_openings.each do |opening|
      openings << {"start" => opening["start"] + week.week,
       "end" => opening["end"] + week.week,
       "title" => opening["title"]
      }
    end
  end
  one_week_openings + openings
end

def week_openings(day, space)
  monday = day - (day.wday - 1)
  space.availabilities.all.collect do |availability|
  {"start" => DateTime.new(monday.year, monday.month, monday.day, availability.start_time.hour, availability.start_time.strftime("%m").to_i) + (availability.day - 1).day,
   "end" => DateTime.new(monday.year, monday.month, monday.day, availability.end_time.hour, availability.end_time.strftime("%m").to_i) + (availability.day - 1).day,
   "title" => "",
   "day" => availability.day}
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



