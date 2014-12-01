class PinsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @pin = @post.pins.new(user_id: current_user.id)

    respond_to do |format|
      if @pin.save
        format.html{redirect_to @pin.post, notice: 'Success! Post pinned.'}
        format.js
      else
        format.html{redirect_to @pin.post, alert: DEFAULT_ERROR_MSG}
        format.js{render partial: '/shared/js_errors', locals: {error: DEFAULT_ERROR_MSG}}
      end
    end
  end

  def destroy
    @pin = Pin.find(params[:id])

    respond_to do |format|
      if @pin.destroy
        format.html{redirect_to @pin.post, notice: 'Success! Post unpinned.'}
        format.js
      else
        format.html{redirect_to @pin.post, alert: DEFAULT_ERROR_MSG}
        format.js{render partial: '/shared/js_errors', locals: {error: DEFAULT_ERROR_MSG}}
      end
    end
  end
end

