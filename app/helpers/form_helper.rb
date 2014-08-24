module FormHelper
  def form_errors_for(object)
    if object.errors.messages.present?
      errors = []
      @user.errors.full_messages.each do |msg|
        errors << "<li>#{msg}</li>"
      end
      
      "<div class='formErrors'>
        <h3 class='errorsHeader'>Form Errors</h3>
        <ul>#{errors.join}</ul>
       </div>".html_safe
    end
  end
end