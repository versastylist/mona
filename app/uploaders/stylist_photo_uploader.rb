class StylistPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
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

  version :gallery do
    process :resize_to_limit => [100, 100]
  end
end
