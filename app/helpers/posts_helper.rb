module PostsHelper
  def cancel_post_path(post)
    if post.new_record?
      root_path
    else
      post_path(post)
    end
  end

  def voting_link(value, post, existing_vote)
    path = post_vote_path(post, rep_val: value)
    upvote = value > 0
    css_classes = upvote ? "like" : "dislike"
    title = upvote ? '+1' : '-1'

    if existing_vote && existing_vote.value == value
      css_classes += " voted"
      title += ' (voted)'
    end

    unless current_user
      css_classes += " loginPopupLink"
    end

    link_to '', path, method: :put, class: css_classes, title: title
  end

  def reputation_display(rep)
    value = rep.to_i

    if value == 0
      css_class = "neutral"
    elsif value < 0
      css_class = "negative"
    elsif value > 0
      css_class = "positive"
    end
      
    content_tag :span, value, class: css_class
  end
end
