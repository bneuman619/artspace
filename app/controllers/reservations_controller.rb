class ReservationsController < ApplicationController
  include ReservationHelpers

  def index
    @space = Space.find(params[:space_id])
    @reservations = @space.reservations
  end

  def create
    if params["payment_info"]["amount"].to_i > 0
      secret_key = get_secret_key(params["reservation_data"]["space_id"])
      response = make_payment(params["payment_info"], secret_key)

      if response.paid
        resp = create_reservations(params["reservation_data"])
        resp["payment"] = response
        resp["totalCharge"] = resp["payment"]["amount"]
        render json: resp.to_json

      else
        render json: {status: 'error', error: 'problem with charge'}.to_json
      end

    else
      reservation_info = create_reservations(params["reservation_data"])
      reservation_info[:total_price] = 0
      render json: reservation_info.to_json
    end
  end

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




