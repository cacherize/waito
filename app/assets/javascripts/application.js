// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require parsley.remote.min
//= require parsley.min
//= require parsley.i18n.en

$(document).ready(function(){
  $("#logoLink").hover(function(){
    $("#logo").stop().animate({bottom: '14px'});
  }, function(){
    $("#logo").stop().animate({bottom: 0});
  });

  if ($(".flash").length > 0) {
    timeoutFlashMessage();

    $(".flash").on('click', '.flashShow, .flashClose', function(event){
      var $that = $(this),
          $parent = $that.parent('.flash'),
          $flashMsg = $that.siblings("p");


      if ($flashMsg.is(":visible")) {
        $that.hide();

        $flashMsg.stop().slideUp(function(){
          $that.siblings('.flashShow').show();
        });
      } else {
        timeoutFlashMessage();
      }
      event.preventDefault();
    });
  }
});

var timeoutFlashMessage = function() {
  var $flashMsg = $(".flash p");
  $(".flash .flashShow").hide();
  $flashMsg.stop().slideDown(function(){
    $(".flash .flashClose").show();
  }).delay(6000).slideUp({
    start: function(){
      $(".flash .flashClose").hide()
    },
    complete: function(){
      $(".flash .flashShow").show()
    }
  });
}