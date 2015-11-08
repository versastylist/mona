class StylistPhotosController < ApplicationController
  def create
    if current_user.can_upload_more_photos?
      photo = current_user.stylist_photos.new(photo_params)
      if photo.save
        redirect_to stylist_path(current_user),
          success: 'Added photo to your gallery'
      else
        redirect_to :back,
          warning: 'Something went wrong'
      end
    else
      redirect_to :back,
        danger: "You're not allowed to upload more than 8 photos"
    end
  end

  private

  def photo_params
    params.require(:stylist_photo).permit(:image, :description)
  end
end
