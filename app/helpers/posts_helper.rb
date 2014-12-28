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

      return content_tag :span, '', class: css_classes, title: 'Already voted'
    else
      css_classes += " loginPopupLink" unless current_user

      return link_to '', path, method: :put, class: css_classes, title: title, onclick: "voteProcessingAnim(this);", remote: current_user.present?
    end
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
      link_to content_tag(:span, '', class: 'actionIcon report') + ' Post Flagged', flag, method: :delete, class: 'actionLink successLink', title: 'Remove flag'
    else
      link_to content_tag(:span, '', class: 'actionIcon report') + ' Flag Post', '', class: 'actionLink reportLink'+login_popup_class, title: 'Flag post'
    end
  end

  def post_pin_link(post)
    if current_user && pin = post.pins.where(user_id: current_user.id).first
      link_to content_tag(:span, '', class: 'actionIcon pin') + ' Post Pinned', pin, method: :delete, class: 'actionLink successLink unpinLink', title: 'Unpin post', remote: true
    else
      link_to content_tag(:span, '', class: 'actionIcon pin') + ' Pin Post', post_pins_path(post), method: :post, class: 'actionLink pinLink'+login_popup_class, title: 'Pin post', remote: true
    end
  end
end
