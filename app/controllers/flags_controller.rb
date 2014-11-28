class FlagsController < ApplicationController
  def create
    load_flaggable
    @flag = @flaggable.flags.new(params[:flag].merge(user_id: current_user.id))

    respond_to do |format|
      if @flag.save
        format.html{redirect_to @flaggable, notice: 'Thank you for the feedback!'}
      else
        format.html{redirect_to @flaggable, alert: DEFAULT_ERROR_MSG}
      end
    end
  end

  def destroy
  end

private

  def load_flaggable
    resource, id = request.path.split('/')[1, 2]
    @flaggable = resource.singularize.classify.constantize.find(id)
  end
end
