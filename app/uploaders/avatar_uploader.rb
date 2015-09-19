# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
