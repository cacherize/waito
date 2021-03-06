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
//= require select2

$(document).ready(function(){
  $("#logoLink").hover(function(){
    $("#logo").stop().animate({bottom: '14px'});
  }, function(){
    $("#logo").stop().animate({bottom: 0});
  });

  if ($(".flash").length > 0) {
    initializeFlashMessageLinks()
  }

  $("#content").on('click', '.loginPopupLink', function(event){
    $("#loginPopup").popup();
    return false;
  });
});

var initializeFlashMessageLinks = function() {
  timeoutFlashMessage();
  
  $(".flash").on('click', '.flashShowLink, .flashCloseLink', function(event){
    var $that = $(this),
        $parent = $that.closest('.flash'),
        $flashMsg = $parent.children("p");


    if ($flashMsg.is(":visible")) {
      $that.parent().hide();

      $flashMsg.stop().slideUp(function(){
        $parent.children('.flashShow').show();
      });
    } else {
      timeoutFlashMessage();
    }
    event.preventDefault();
  });
}

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

$.fn.popup = function() {
  var $el, $box;
  $el = this;
  $box = $el.find('.box');
  
  $el.show();
  $box.slideDown();

  $('.boxClose, .backdrop').on('click', function(event){
    $box.slideUp(function(){
      $el.hide();
    });

    event.preventDefault();
  });

  $box.on('click', function(event){
    event.stopPropagation();
  });
};

$.fn.sortMenu = function() {
  var $menu = this, $display, $selected, $list, $wrap;

  $menu.wrap("<div class='sMenu'></div>");
  $display = $menu.parent(".sMenu");
  
  if ($menu.children("li.selected").length > 0) {
    $selected = $menu.children("li.selected").first();
  } else {
    $selected = $menu.children("li").first();
  };

  $menu.before("<span class='sMenuSelected link' href='#'>"+$selected.text()+" \u25BE</a>");

  $display.on({
    mouseover: function(){ $menu.show() },
    mouseleave: function(){ $menu.hide() },
    click: function(){
      if ($menu.is(":visible")) {
        $menu.hide();
      } else {
        $menu.show();
      }
    }
  });
};

$.fn.dropMenu = function(button) {
  var $menu = this, $button = $(button), $display;

  $button.addClass('dm');
  $menu.addClass('dm');
  
  $menu.parent().children('.dm').wrapAll("<div class='dMenu'></div>")
  $display = $menu.parent(".dMenu");

  $display.mouseover(function(){ $menu.show() });
  $display.mouseleave(function(){ $menu.hide() });
  $button.click(function(event){
    if ($menu.is(":visible")) {
      $menu.hide();
    } else {
      $menu.show();
    }

    event.preventDefault();
  });
};