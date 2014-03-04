class UserMailer < ActionMailer::Base
  default from: "notifications@artspace.com"

  def confirmation_email(reservations, total_charge)
    @user = current_user
    @total_charge = total_charge
    @reservations = reservations
    @space = @reservations.first.space
    mail(to: @user.email, subject: 'Artspace.com reservation confirmation')
  end

end
