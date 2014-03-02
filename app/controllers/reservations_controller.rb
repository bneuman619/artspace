class ReservationsController < ApplicationController

  def create
    @space = Space.find(params[:spaceId])
    reservation_data = params["data"]
    reservations = reservation_data.values.collect do |reservation|
      @space.reservations.new(
        renter: current_user,
        start_time: reservation[:start],
        end_time: reservation[:end],
        intended_use: reservation[:intended_use],
        num_people: reservation[:num_people])
    end

    invalid_reservations = reservations.select { |reservation| invalid_timerange_check(reservation) }
        
    if !invalid_reservations.empty?
      render json: {status: 'error', error: "Invalid reservations"}.to_json
    else
      reservations.each(&:save)

      total_hours = reservations.inject(0) { |hours, reservation| hours += reservation.length_in_hours }
      reservation_info = {
        status: 'success',
        spaceId: @space.id,
        totalCharge: ((total_hours * @space.rate).round(2)) * 100,
        reservation_ids: reservations.collect(&:id),
        space_title: @space.title,
        email: current_user.email
      }
  
      render json: reservation_info.to_json
    end
  end

  def show
  end

  def destroy
  end
end

def invalid_timerange_check(reservation)
  reservation.space.reservations.any? do |space_reservation|
    space_reservation.start_time.between?(reservation.start_time, reservation.end_time) ||
    space_reservation.end_time.between?(reservation.start_time, reservation.end_time)
  end                               
end
