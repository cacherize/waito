$(document).ready(function(){
  var $form = $('.form'),
      $submit = $form.find(":submit");

  $form.psly({
    trigger: 'blur',
    successClass: 'validSuccess',
    errorClass: 'validError'
  });

  // $.listen('parsley:form:validated', function(form){
  //   console.log(form)
  //   var $errors = window.ParsleyUI.getErrorsMessages(form)

  //   if ($errors.length == 0) {
  //     $submit.removeAttr('disabled');
  //     $submit.removeClass('disabled');
  //   } else {
  //     $submit.attr('disabled', 'disabled');
  //     $submit.addClass('disabled');
  //   }
  // });

  $.listen('parsley:field:success',function(field){
    field.$element.siblings(".parsley-errors-list").html("<li class='validField'>That works!</li>")
  });

  $.listen('parsley:field:error',function(field){
    field.$element.siblings(".parsley-errors-list").find(".validField").remove()
  });
});
