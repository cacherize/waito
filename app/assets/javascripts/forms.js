$(document).ready(function(){
  var $form = $('.form'),
      $submit = $form.find(":submit");

  $form.psly({
    trigger: 'blur',
    successClass: 'validSuccess',
    errorClass: 'validError'
  });

  $.listen('parsley:field:success',function(field){
    var $el = field.$element

    if ( $el.parent().is( "div.field_with_errors" ) ) {
      $el.unwrap();
    }

    $el.siblings(".parsley-errors-list").html("<li class='validField'>That works!</li>")
  });

  $.listen('parsley:field:error',function(field){
    field.$element.siblings(".parsley-errors-list").find(".validField").remove()
  });
});
