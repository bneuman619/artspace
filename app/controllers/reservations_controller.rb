class ReservationsController < ApplicationController

  def create
    @space = Space.find(params[:spaceId])
    reservation_data = params["data"]
    reservations = reservation_data.values.collect do |reservation|
      @space.reservations.create(
        renter: current_user,
        start_time: reservation[:start],
        end_time: reservation[:end],
        intended_use: reservation[:intended_use],
        num_people: reservation[:num_people])
    end

    total_hours = reservations.inject(0) { |hours, reservation| hours += reservation.length_in_hours }
    
    reservation_info = {
      spaceId: @space.id,
      totalCharge: ((total_hours * @space.rate).round(2)) * 100,
      reservation_ids: reservations.collect(&:id),
      space_title: @space.title,
      email: current_user.email
    }
  
    render json: reservation_info.to_json
  end

  def show
  end

  def destroy
  end

end
