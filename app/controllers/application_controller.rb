class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end

  # def create_reservations(reservation_data)
  #   @space = Space.find(reservation_data[:space_id])
  #   reservations = reservation_data[:reservations].values.collect do |reservation|
  #     @space.reservations.new(
  #         renter: current_user,
  #         start_time: reservation[:start],
  #         end_time: reservation[:end],
  #         intended_use: reservation[:intended_use],
  #         num_people: reservation[:num_people])
  #   end

  #   invalid_reservations = get_invalid_reservations(reservations)

  #   if invalid_reservations
  #     {status: 'error', error: "Invalid reservations", invalid_reservations: invalid_reservations}
  #   else
  #     reservations.each(&:save)
  #     {status: 'success', reservation_ids: reservations.collect(&:id)}
  #   end
  # end

  # def get_invalid_reservations(reservations)
  #   invalid_reservations = reservations.select { |reservation| invalid_timerange_check(reservation) }
  #   (invalid_reservations.empty?) ? nil : invalid_reservations
  # end

  # def invalid_timerange_check(reservation)
  #   reserved_timerange_check(reservation)
  # end

  # def reserved_timerange_check(reservation)
  #   reservation.space.reservations.any? do |space_reservation|
  #     space_reservation.start_time.between?(reservation.start_time, reservation.end_time) ||
  #     space_reservation.end_time.between?(reservation.start_time, reservation.end_time)
  #   end
  # end
end
