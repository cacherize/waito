class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_or_username(params[:login])
    
    if user
      user.reset_password
    end

    respond_to do |format|
      format.html{redirect_to root_path, notice: "Check your inbox for a password with reset instructions."}
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
  end

  def update
  end
end
