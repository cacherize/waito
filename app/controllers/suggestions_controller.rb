class SuggestionsController < ApplicationController
  def index
    @suggestions = Suggestion.all
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = current_user.suggestions.new(params[:suggestion])
    
    respond_to do |format|
      if @suggestion.save
        format.html{redirect_to suggestions_path, notice: 'Success! Thank you for your suggestion!'}
      else
        format.html{render :new}
      end
    end
  end

  def edit
  end

  def update
  end

  def show
  end
end
