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
    css_classes = value > 0 ? "like" : "dislike"

    if existing_vote && existing_vote.value == value
      css_classes += " voted"
    end

    link_to '', path, method: :put, class: css_classes
  end
end
