module ProfilesHelper
  def user_photo_display(user)
    if user.user_photo.attached?
      image_tag user.user_photo, size: "150x150"
    else
      image_tag 'default_user_photo.png', size: "150x150" # Placeholder image
    end
  end
end
