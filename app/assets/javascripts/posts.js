$(document).ready(function(){
  $(".sortMenu").sortMenu();
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