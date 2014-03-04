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
    render text: params.to_s
  end

  def destroy
  end

  def undo
    puts params.to_s
    deleted = Reservation.where(id: params["reservation_ids"]).destroy_all
    render json: deleted.to_json
  end
end



def unavailable_timerange_check(reservation)
  reservation.space.availabilities.none? do |availability|
    reservation.start_time.between?(availability.start_time, availability.end_time) &&
    reservation.end_time.between?(availability.start_time, availability.end_time)
  end
end


