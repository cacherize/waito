class UsernameCheckController < ApplicationController
  def index
    username = params[:user][:username]
    username ||= params[:user][:email]
    
    user = User.find_by_email_or_username(username)

    respond_to do |format|
      if user
        format.html{head :no_content}
      else
        format.html{render :file => "#{Rails.root}/public/404.html",  :status => 404}
      end
    end
  end
end
