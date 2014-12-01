class PinsController < ApplicationController
  def create
    @pin = Pin.new(params[:pin])

    respond_to do |format|
      if @pin.save
        format.html{redirect_to @pin.post, notice: 'Success! Post pinned.'}
      else
        format.html{redirect_to @pin.post, alert: DEFAULT_ERROR_MSG}
      end
    end
  end

  def destroy
    @pin = Pin.find(params[:id])

    respond_to do |format|
      if @pin.destroy
        format.html{redirect_to @pin.post, notice: 'Success! Post unpinned.'}
      else
        format.html{redirect_to @pin.post, alert: DEFAULT_ERROR_MSG}
      end
    end
  end
end

