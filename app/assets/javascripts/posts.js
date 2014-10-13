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
      }).done(function(){
        $("#commentForm_"+$rel).slideDown();
      });
    }
    

    event.preventDefault();
  });
});

var loadPostComments = function(){
  var $target = $("#commentList");

  $.get($target.attr("rel"), {full_load: true}, function(data){
    $target.html(data);
  }).done(function(){
    $(".sortMenu").sortMenu();
    $("#commentList .comment").infinitescroll({
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#commentList .comment"
    });
  });

  $target.on('click', '.sortMenu li a', function(event){
    $.get(this.href, {full_load: true}, function(data){
      $target.html(data);
    }).done(function(){
      $(".sortMenu").sortMenu();
        $("#commentList .comment").infinitescroll({
        navSelector: "nav.pagination",
        nextSelector: "nav.pagination a[rel=next]",
        itemSelector: "#commentList .comment"
      });
    });

    event.preventDefault();
  });
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