$(document).ready(function(){
  $("#commentList").on('click', '.replyFormLoadLink', function(event){
    var $that = $(this),
        $comment = $that.closest('.comment'),
        $container = $that.closest("#commentList"),
        $comment_id = $that.data('comment-id');

    $container.find(".subCommentForm").hide();

    if ($("#commentForm_"+$comment_id).length > 0) {
      $("#commentForm_"+$comment_id).slideDown();
    } else {
      $.get(this.href, function(data){
        if ($comment.children('.postSubcomments').length > 0) {
          $comment.children('.postSubcomments').prepend(data);
        } else {
          $comment.append("<div class='postSubcomments'>"+data+"</div>");
        }
      }).done(function(){
        $("#commentForm_"+$comment_id).slideDown();
      });
    }
    

    event.preventDefault();
  });
});

var initializePostShow = function(){
  var $target = $("#commentList");
  
  $(".dropMenu").dropMenu('.reportLink')
  renderComments($target.data("comment-load-path"));

  $target.on('click', '.dropMenu li a', function(event){
    renderComments(this.href);

    event.preventDefault();
  });
}

var renderComments = function(url){
  $.get(url);
}

var collapseSubcomments = function(link){
  var $parent, $subcomments, text; 

  $parent = $(link).parent("p");
  $subcomments = $parent.closest(".postSubcomments").children(".subcommentList");
  text = $subcomments.is(':visible') ? 'Show replies' : 'Hide replies';

  $subcomments.slideToggle();
  $(link).text(text);
}

var closeReplyForm = function(link){
  $(link).closest(".subCommentForm").slideUp();
}

var voteProcessingAnim = function(link){
  $(link).parent().html("<img src='/assets/loader.gif' alt='loading...' />")
}