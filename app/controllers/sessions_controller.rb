class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:alert] = "Invalid email or password"
      render 'sessions/new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
