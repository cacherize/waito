class TagsController < ApplicationController
  def index
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html{redirect_to tags_path, notice: "Successfully added tag!"}
      else
        format.html{render :new}
      end
    end
  end

  def edit
  end

  def update
  end
end
