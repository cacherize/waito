class SessionsController < ApplicationController
  skip_filter :store_path
  
  def new
  end

  def create
    user = User.find_by_email_or_username(params[:login])

    if user && user.authenticate(params[:password])
      if !user.activated?
        flash.now.alert = "Check your inbox for an account activation email. You must activate your account first to login."
        render :new
        return
      end

      session[:user_id] = user.id
      redirect_back_or_default(root_url)
      flash[:notice] = "Successfully logged in!"
    else
      flash.now.alert = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Successfully logged out!'
  end
end
