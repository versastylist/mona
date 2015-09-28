# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  def default_url
    "https://vs-media-dev.s3.amazonaws.com/uploads/registration/avatar/1/thumb_icon-user-default.png"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_limit => [200, 200]
  end

  version :micro do
    process :resize_to_limit => [50, 50]
  end
end
