module UsersHelper
  def user_med_avatar(user)
    content_tag :div, class: 'userImageMedWrapper' do
      link_to_if user, image_tag(user.avatar_url, class: 'userImageMed'), user
    end
  end

  def user_lg_avatar(user)
    content_tag :div, class: 'userImageWrapper' do
      link_to_if user, image_tag(user.avatar_url, class: 'userImage'), user
    end
  end
end
