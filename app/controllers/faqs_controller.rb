class FaqsController < ApplicationController
  def index
    @faqs = Faq.all
  end

  def update
    @faq = Faq.find(params[:id])

    respond_to do |format|
      if @faq.update_attributes(params[:faq])
        format.html {render :index}
      else
        format.html {redirect_to faqs_path, notice: "Success! Updated FAQ!"}
      end
    end
  end

  def create
    @faq = Faq.new(params[:faq])

    respond_to do |format|  
      if @faq.save
        format.html {render :index}
      else
        format.html {redirect_to faqs_path, notice: "Success! Added FAQ!"}
      end
    end
  end
end
