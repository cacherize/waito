// ClientSideValidations.callbacks.element.before = function($element, callback) {
//   // callback();

//   // Add a success message to give the user an ego lift.
//   $element.siblings(".validMsg").text('');
//   // $message = $('<label for="'+el_id+'" class="message validField">Great job!</label>');
//   // $element.after($message);
// };

ClientSideValidations.callbacks.element.fail = function($element, message, callback, eventData) {
  $element.siblings('.validField').remove();
  callback();
  // Add a success message to give the user an ego lift.
  // $element.closest('div').remove('.validField');
};

ClientSideValidations.callbacks.element.pass = function($element, callback) {
  callback();
  $element.siblings('.validField').remove();
  $element.after('<span class="validField">That works!</span');
  // Add a success message to give the user an ego lift.
};

var userEmailValidator = function() {
  var $el = $("#user_email");
  $el.on('blur', function(){
    if ($el.val() == "") {return}
      
    var invalid, message;
    invalid = !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test($el.val())
    
    if (!invalid) {return}
    message = "Invalid email"

    if ($el.siblings(".invalidField").length > 0) {
      $el.siblings(".invalidField").val(failMessage);
    } else {
      $el.siblings('.validField').remove();
      $el.siblings('label').wrap("<div class='field_with_errors'></div>");
      $el.wrap("<div class='field_with_errors'></div>");
      $el.after("<label class='message invalidField' for='user_email'>"+message+"</label>");
    }
  });
}