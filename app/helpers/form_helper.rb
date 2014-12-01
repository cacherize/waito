module FormHelper
  def form_errors_for(object)
    return unless object
    
    if object.errors.messages.present?
      errors = []
      object.errors.full_messages.each do |msg|
        errors << content_tag(:li, msg)
      end
      
      content_tag :div, class: 'formErrors' do
        content_tag(:h3, 'Form Errors', class: 'errorsHeader') +
        content_tag(:ul, errors.join.html_safe)
      end
    end
  end
end