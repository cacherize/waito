class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_or_username(params[:login])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Successfully logged in!"
    else
      flash.now.alert = "Invalid username/email and password combination"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Successfully logged out!'
  end
end
