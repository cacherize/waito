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

  def post_reputation(votes)
    votes.pluck(:value).inject(:+).to_i # sum votes together
  end
end
