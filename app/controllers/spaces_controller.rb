class SpacesController < ApplicationController
  include CalendarHelpers

  def index
    @spaces = Space.scoped.where(active: 1)
    @spaces = @spaces.title(params[:title]) if params[:title].present?
    @spaces = @spaces.rate_less(params[:rate]) if params[:rate].present?
  end

  def new
    redirect_to root_path if !current_user
    @space = Space.new
  end

  def create
    @use_ids = params[:space][:use_ids] ||= []
    @space = Space.new(space_params)
    @space.creator_id = current_user.id
    if @space.save
      insert_uses(@space.id, @use_ids)
      save_photos(@space, params["pic_url"])
      redirect_to new_space_availability_path(@space)
    else
      flash[:notice] = "Space could not be saved! " + @space.errors.full_messages
    end
  end

  def show
    @space = Space.find(params[:id])
    @calendar_info = calendar_info(@space).to_json
    @publishable_key = @space.creator.publishable_key
  end

  def edit
    @space = Space.find(params[:id])
    if !session[:current_user_id]
      render "welcome/index"
    elsif session[:current_user_id] != @space.creator_id
      redirect_to user_path(current_user.id)
    end
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

  def add_photo
    redirect_to new_space_path
  end

  def update_pic
    puts @space = Space.find_by_id(params["space_id"])
    if params["pic_url"]
      params["pic_url"].split(',').each do |url|
        Photo.create(space: @space, url: url)
      end
    end
    redirect_to manage_path(current_user.id)
  end

  def edit_pic
    @space = Space.find(params[:id])
    @photos = Photo.where(space_id: @space.id).all
    if !session[:current_user_id]
      render "welcome/index"
    elsif session[:current_user_id] != @space.creator_id
      redirect_to user_path(current_user.id)
    end
  end

  def delete_photo
    Photo.destroy(params["id"])
    redirect_to user_path(current_user.id)
  end

  private

  def space_params
    params.require(:space).permit(:title, :description, :dimensions,
                                  :ammenities, :rate, :address,
                                  :city, :state, :zipcode, :email,
                                  :phone)
  end

  def insert_uses(space_id, use_ids)
    @use_ids.each do |u|
      SpaceUse.create(space_id: @space.id, use_id: u.to_i)
    end
  end

  def save_photos(space, pic_url)
    if pic_url
      pic_url.split(',').each do |url|
        Photo.create(space: space, url: url)
      end
    else
      space.photos << Photo.first
    end
  end

end


# def calendar_info(space)
#   {openings: get_openings_for_four_weeks(week_openings(DateTime.now, space)),
#    reservations: get_reservations(space)
#   }
# end

# def get_openings(space)
#   get_openings_for_four_weeks(week_openings(DateTime.now, space))
# end

# def get_openings_for_four_weeks(one_week_openings)
#   openings = []
#   (1..3).each do |week|
#     one_week_openings.each do |opening|
#       openings << {"start" => opening["start"] + week.week - 1.hour,
#        "end" => opening["end"] + week.week - 1.hour,
#        "title" => opening["title"]
#       }
#     end
#   end
#   one_week_openings + openings
# end

# def week_openings(day, space)
#   sunday = day - day.wday.day
#   space.availabilities.all.collect do |availability|
#     {"start" => convert_availability_date(sunday, availability.start_time, availability.day, false),
#      "end" => convert_availability_date(sunday, availability.end_time, availability.day, true),
#      "title" => "",
#      "day" => availability.day,
#      "id" => availability.id}
#   end
# end

# def convert_availability_date(sunday, availability_dt, day_num, end_time)
#   adjusted_availability = if availability_dt.hour < 6
#     availability_dt + 18.hour
#   elsif availability_dt.hour == 6 && end_time
#     availability_dt + 18.hour - 1.minute
#   else
#     availability_dt - 6.hour
#   end

#   DateTime.new(sunday.year, sunday.month, sunday.day, adjusted_availability.hour, adjusted_availability.min, 0, '-6') + day_num.day
# end

# def get_reservations(space)
#   space.reservations.all.collect do |reservation|
#     {"id" => reservation.id,
#      "start" => reservation.start_time,
#      "end" => reservation.end_time,
#       "title" => reservation.renter.first_name + reservation.renter.last_name}
#   end
# end



