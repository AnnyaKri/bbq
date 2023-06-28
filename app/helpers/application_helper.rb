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

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      url_for(photos.sample.photo)
    else
      asset_path('event.jpg')
    end
  end
end
