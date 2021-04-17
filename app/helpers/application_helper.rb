module ApplicationHelper
  def avatar_url(user)
    if user.avatar.attached?
      url_for(user.avatar)
    elsif user.image
      user.image
    else
      'woman.png'
    end
  end

  def missing_pet_img(pet)
    if pet.pet_photos.attached?
      url_for(pet.pet_photos[0])
    else
      'no-image.png'
    end
  end
end
