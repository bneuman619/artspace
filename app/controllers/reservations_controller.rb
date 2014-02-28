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

    render json: "SUCCESS!"
  end

  def show
  end

  def destroy
  end

end
