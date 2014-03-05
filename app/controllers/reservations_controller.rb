class ReservationsController < ApplicationController

  def index
    @space = Space.find(params[:space_id])
    @reservations = @space.reservations
  end

  def create
    reservation_info = create_reservations(params)
    reservation_info[:total_price] = 0
    render json: reservation_info.to_json
  end

  # def show
  # end

  def destroy
  end

  def confirmation
    @total_charge = "$" + (params["amount"].to_i / 100).to_s + ".00"
    
    reservation_ids = params["ids"].split(",").map(&:to_i)
    @reservations = []
    reservation_ids.each do |id|
      @reservations  << Reservation.find(id)
    end
    @reservations.sort! {|x,y| x.start_time <=> y.start_time}
    @space = @reservations.first.space
    
    # UserMailer.confirmation_email(current_user, @reservations, @total_charge).deliver

  end
end



def unavailable_timerange_check(reservation)
  reservation.space.availabilities.none? do |availability|
    reservation.start_time.between?(availability.start_time, availability.end_time) &&
    reservation.end_time.between?(availability.start_time, availability.end_time)
  end
end


