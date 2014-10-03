$(document).ready(function(){
  $(".sortMenu").sortMenu();
  $("#commentList").on('click', '.replyFormLoadLink', function(event){
    var $that = $(this),
        $constraint = $that.closest('.postComment'),
        $container = $that.closest("#commentList"),
        $rel = $that.attr('rel');

    $container.find(".subCommentForm").hide();

    if ($("#commentForm_"+$rel).length > 0) {
      $("#commentForm_"+$rel).slideDown();
    } else {
      $.get(this.href, function(data){
        $constraint.after(data);
      });
    }

    event.preventDefault();
  });
});