class UsersController < ApplicationController

  def new
    if current_user
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "Invalid info - check to make sure passwords match"
      render 'users/new'
    end
  end

  def show
  end

  def manage
    if session[:current_user_id]
      @spaces = current_user.spaces_created
      creator_id = @spaces.first.creator_id
    else
      render "welcome/index"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation)
  end

end
