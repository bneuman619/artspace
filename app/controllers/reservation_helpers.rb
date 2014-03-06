module ReservationHelpers
  def create_reservations(reservation_data)
    @space = Space.find(reservation_data[:space_id])
    reservations = reservation_data[:reservations].values.collect do |reservation|
      @space.reservations.new(
          renter: current_user,
          start_time: reservation[:start],
          end_time: reservation[:end],
          intended_use: reservation[:intended_use],
          num_people: reservation[:num_people])
    end

    # invalid_reservations = get_invalid_reservations(reservations)

    # if invalid_reservations
    #   {status: 'error', error: "Invalid reservations", invalid_reservations: invalid_reservations}
    # else
      reservations.each(&:save)
      {status: 'success', reservation_ids: reservations.collect(&:id)}
    # end
  end

  def make_payment(payment_info, payee_secret_key)
    token = payment_info["token_key"] # obtained with checkout.js
    amount = payment_info["amount"]
    description = payment_info["description"]
    Stripe.api_key = payee_secret_key

    Stripe::Charge.create(
      :amount => amount,
      :currency => "usd",
      :card => token,
      :description => description
    )
  end

  def get_secret_key(space_id)
    Space.find(space_id).creator.secret_key
  end

  def get_invalid_reservations(reservations)
    invalid_reservations = reservations.select { |reservation| invalid_timerange_check(reservation) }
    (invalid_reservations.empty?) ? nil : invalid_reservations
  end

  def invalid_timerange_check(reservation)
    reserved_timerange_check(reservation)
  end

  def reserved_timerange_check(reservation)
    reservation.space.reservations.any? do |space_reservation|
      space_reservation.start_time.between?(reservation.start_time, reservation.end_time) ||
      space_reservation.end_time.between?(reservation.start_time, reservation.end_time)
    end
  end
end
