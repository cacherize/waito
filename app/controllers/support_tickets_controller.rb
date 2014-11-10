class SupportTicketsController < ApplicationController
  def new
    @ticket = SupportTicket.new
  end

  def create
    @ticket = SupportTicket.new(params[:support_ticket])

    respond_to do |format|
      if @ticket.save
        format.html{redirect_to root_path, notice: "Your ticket has been received. Please wait 24-48 hours if a response is necessary."}
      else
        format.html{render :new}
      end
    end
  end

  def index
  end
end
