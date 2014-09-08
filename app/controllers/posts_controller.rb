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
  end
end
