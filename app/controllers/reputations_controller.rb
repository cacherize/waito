class ReputationsController < ApplicationController
  skip_filter :store_path
  before_filter :authenticate_user

  def update
    load_reputable
    @rep = Reputation.create_or_update_rep(@reputable, current_user, params[:rep_val])
    sleep 0.5

    respond_to do |format|
      if @rep.save
        format.html{redirect_to request.referer, notice: "Success! Voted!"}
        format.js {
          @reputation = @reputable.reputations.pluck(:value).inject(:+)
        }
      else
        format.html{redirect_to request.referer, alert: DEFAULT_ERROR_MSG}
        format.js{render partial: '/shared/js_errors', locals: {error: DEFAULT_ERROR_MSG}}
      end
    end
  end

private

  def load_reputable
    resource, id = request.path.split('/')[1, 2]
    @reputable = resource.singularize.classify.constantize.find(id)
  end
end
