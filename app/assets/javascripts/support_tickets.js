$(document).ready(function(){
  var $field = $("#support_ticket_message");

  function updateCharCount(el) {
    $("#supportMessageCharCount").text(1000 - el.value.length);
  };

  $field.each(function(){
    updateCharCount(this);
  })

  $field.keyup(function(){
    updateCharCount(this);
  });
});