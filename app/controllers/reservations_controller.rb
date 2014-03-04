class ReservationsController < ApplicationController

  def create
    reservation_info = create_reservations(params)
    reservation_info[:total_price] = 0
    render json: reservation_info.to_json
  end

  def show
  end

  def destroy
  end
end



def unavailable_timerange_check(reservation)
  reservation.space.availabilities.none? do |availability|
    reservation.start_time.between?(availability.start_time, availability.end_time) &&
    reservation.end_time.between?(availability.start_time, availability.end_time)
  end
end


