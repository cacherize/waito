$(document).ready(function(){
  $("#commentList").on('click', '.replyFormLoadLink', function(event){
    var $that = $(this),
        $comment = $that.closest('.comment'),
        $container = $that.closest("#commentList"),
        $rel = $that.attr('rel');

    $container.find(".subCommentForm").hide();

    if ($("#commentForm_"+$rel).length > 0) {
      $("#commentForm_"+$rel).slideDown();
    } else {
      $.get(this.href, function(data){
        if ($comment.children('.postSubcomments').length > 0) {
          $comment.children('.postSubcomments').prepend(data);
        } else {
          $comment.append("<div class='postSubcomments'>"+data+"</div>");
        }
      });
    }

    event.preventDefault();
  });
});

var loadPostComments = function(){
  var $target = $("#commentList");

  $.get($target.attr("rel"), function(data){
    $target.append(data);
  }).done(function(){
    $(".sortMenu").sortMenu();
  });

  $target.on('click', '.sortMenu li a', function(event){
    $.get(this.href, function(data){
      $target.html(data)
    }).done(function(){
      $(".sortMenu").sortMenu();
    });

    event.preventDefault();
  });
}