class PostsController < ApplicationController
  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html{redirect_to @post, notice: "Success! Added post!"}
      else
        format.html{render :new}
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
