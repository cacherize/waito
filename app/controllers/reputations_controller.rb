class ReputationsController < ApplicationController
  before_filter :authenticate_user
  
  def update
    load_reputable
    @rep = Reputation.create_or_update_rep(@reputable, current_user, params[:rep_val])
    
    respond_to do |format|
      if @rep.save
        format.html{redirect_to request.referer, notice: "Success! Voted!"}
      else
        format.html{redirect_to request.referer, alert: 'An error occurred. Please try again.'}
      end
    end
  end

private

  def load_reputable
    resource, id = request.path.split('/')[1, 2]
    @reputable = resource.singularize.classify.constantize.find(id)
  end
end
