class ReservationsController < ApplicationController

  def create
    @space = Space.find(params[:spaceId])
    reservation_data = params["data"]
    reservations = reservation_data.values.collect do |reservation_datum|
      @space.reservations.create(
        renter: current_user,
        start_time: reservation_datum[:start],
        end_time: reservation_datum[:end])
    end

    total_hours = reservations.inject { |hours, reservation| hours += reservation.length_in_hours }
    
    reservation_info = {
      spaceId: @space.id,
      totalCharge: total_hours * @space.rate
    }
    
    render json: reservation_info.to_json
  end

  def show
  end

  def destroy
  end

end
