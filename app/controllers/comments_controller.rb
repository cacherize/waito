class CommentsController < ApplicationController
  def index
    load_commentable
    @comments = Comment.filter_comments(@commentable, params[:comment_sort])

    render partial: 'comments/comment_list'
  end

  def new
    load_commentable
    @comment = Comment.new
    render partial: 'comments/reply_form'
  end

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
