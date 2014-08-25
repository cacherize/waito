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
    @user = User.find_by_password_reset_token(params[:id])

    if params[:user]
      password_attrs = params[:user].keep_if{|k,v| ["password", "password_confirmation"].include?(k)}

      unless password_attrs.any?{|k, v| v.present?}
        password_attrs = nil
        @user.errors.add(:password, 'is required')
      end
    else
      @user.errors.add(:password, 'is required')
    end

    respond_to do |format|
      if password_attrs && @user.update_attributes(params[:user])
        format.html{redirect_to login_path, notice: 'Success! Password has been reset!'}
      else
        format.html{render :edit}
      end
    end
  end
end
