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
  $element.after('<span class="validField">Success!</span');
  // Add a success message to give the user an ego lift.
};
