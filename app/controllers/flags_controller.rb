class FlagsController < ApplicationController
  def create
    load_flaggable
    @flag = @flaggable.flags.new(params[:flag].merge(user_id: current_user.id))

    respond_to do |format|
      if @flag.save
        format.js
        format.html{redirect_to @flaggable, notice: 'Thank you for the feedback!'}
      else
        format.html{redirect_to @flaggable, alert: DEFAULT_ERROR_MSG}
      end
    end
  end

  def destroy
    @flag = Flag.find(params[:id])

    respond_to do |format|
      if @flag.destroy
        format.html {redirect_to @flag.flaggable, notice: "Success! Remove flag from post."}
      else
        format.html {redirect_to @flag.flaggable, alert: DEFAULT_ERROR_MSG}
      end
    end
  end

private

  def load_flaggable
    resource, id = request.path.split('/')[1, 2]
    @flaggable = resource.singularize.classify.constantize.find(id)
  end
end
