class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html{redirect_to root_path, notice: "Success! Sign up complete, please check your inbox for a confirmation email."}
      else
        format.html{render :new}
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html{redirect_to @user, notice: 'Success! Your profile has been updated!'}
      else
        format.html{render :edit}
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.destroy
        format.html{redirect_to root_path, notice: 'Success! Your account has been deleted.'}
      else
        format.html{redirect_to @user, alert: 'An error occurred. Please try again.'}
      end
    end
  end

  def index
    @user = User.all
  end
end
