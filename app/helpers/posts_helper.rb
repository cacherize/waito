module PostsHelper
  def cancel_post_path(post)
    if post.new_record?
      root_path
    else
      post_path(post)
    end
  end

  def voting_link(value, post, existing_vote)
    obj_sym = (post.class.name.underscore + "_id").to_s
    path = url_for(controller: 'reputations', action: 'update', rep_val: value, obj_sym => post)
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

  def post_report_link(post)
    if current_user && flag = post.flags.where(user_id: current_user.id).first
      link_to '<span class="actionIcon report"></span> Post Reported'.html_safe, flag, method: :delete, class: 'actionLink undoLink', title: 'Remove flag'
    else
      link_to '<span class="actionIcon report"></span> Report Post'.html_safe, '', class: 'actionLink reportLink'+login_popup_class, title: 'Flag post'
    end
  end

  def post_pin_link(post)
    link_to '<span class="actionIcon pin"></span> Pin Post'.html_safe, post_pins_path(post), method: :post, class: 'actionLink'+login_popup_class
  end
end
