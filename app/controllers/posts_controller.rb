class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    if @post.deleted?
      render 'deleted'
    else
      reps = @post.reputations
      @votes = reps.pluck(:value).inject(:+)
      if current_user
        @user_vote = reps.select{|v| v.user_id == current_user.id}.first
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html{redirect_to @post, notice: "Success! Added post!"}
      else
        format.html{render :new}
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html {redirect_to @post, notice: 'Success! Updated post!'}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attribute(:deleted_at, Time.zone.now)
        format.html {redirect_to root_path, notice: 'Success! Post deleted!'}
      else
        format.html {redirect_to @post, alert: DEFAULT_ERROR_MSG}
      end
    end
  end
end
