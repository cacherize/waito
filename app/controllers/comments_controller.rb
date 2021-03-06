class CommentsController < ApplicationController
  skip_filter :store_path
  
  def index
    load_commentable
    load_comments = LoadComments.new(@commentable, current_user, params[:page], params[:comment_sort])
    @comments = load_comments.comments
    @conjoined_comments = load_comments.conjoined_comments
    @total = load_comments.total

    respond_to do |format|
      format.js
    end
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
        format.html{redirect_to request.referer, alert: DEFAULT_ERROR_MSG}
      end
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
