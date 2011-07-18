# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/default/" + ["image", version_name].compact.join('_') + '.png'
  end

  version(:icon){ process resize_to_fill: [16, 16] }
  version(:small){ process resize_to_fill: [24, 24] }
  version(:medium){ process resize_to_fill: [48, 48] }
  version(:large){ process resize_to_fill: [73, 73] }

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
