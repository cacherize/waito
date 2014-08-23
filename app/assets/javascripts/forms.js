$(document).ready(function(){
  var $form = $('.form'),
      $submit = $form.find(":submit");

  $form.parsley({
    trigger: 'blur',
    successClass: 'validSuccess',
    errorClass: 'validError'
  })

  $.listen('parsley:field:success',function(field){
    field.$element.siblings(".parsley-errors-list").html("<li class='validField'>That works!</li>")

    if ($(".parsley-error").length == 0) {
      $submit.removeAttr('disabled');
      $submit.removeClass('disabled');
    }
  });

  $.listen('parsley:field:error',function(field){
    field.$element.siblings(".parsley-errors-list").find(".validField").remove()
    $submit.attr('disabled', 'disabled');
    $submit.addClass('disabled');
  });
});
