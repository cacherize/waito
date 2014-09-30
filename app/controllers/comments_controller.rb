class CommentsController < ApplicationController
  def create
    load_commentable
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html{redirect_to request.referer, notice: "Success! Added comment!"}
      else
        format.html{redirect_to request.referer, alert: 'An error occurred. Please try again.'}
      end
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
