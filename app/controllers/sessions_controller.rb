class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now.alert = "Invalid email or password"
      render root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
