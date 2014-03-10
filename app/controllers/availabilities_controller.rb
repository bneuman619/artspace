class AvailabilitiesController < ApplicationController
  include AvailabilityHelpers
  include CalendarHelpers

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
      availabilities.select(&:invaild?).collect {|invalid| invalid.errors.full_messages}
      render json: {status: 'error', message: "Validation error with availabilities", availablities: availabilities}.to_json
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




