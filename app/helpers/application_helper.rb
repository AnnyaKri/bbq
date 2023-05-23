module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(:middle)
    else
      asset_path('user.png')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.attached?
      user.avatar.variant(:thumb)
    else
      asset_path('user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

end
