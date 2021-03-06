class SupportTicketsController < ApplicationController
  def new
    @ticket = SupportTicket.new
  end

  def create
    @ticket = SupportTicket.new(params[:support_ticket])
    @ticket.public_address = request.remote_ip

    respond_to do |format|
      if @ticket.save
        format.html{redirect_to root_path, notice: "Your ticket has been received. Please wait 24-48 hours if a response is necessary."}
      else
        format.html{render :new}
      end
    end
  end

  def index
    @tickets = SupportTicket.order('created_at DESC')
  end

  def update
    @ticket = SupportTicket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:support_ticket])
        format.html{redirect_to support_tickets_path, notice: "Success! Support ticket updated."}
      else
        format.html{render :index}
      end
    end
  end
end
