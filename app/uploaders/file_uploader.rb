class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    Rails.root + "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    Rails.root + "/tmp/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
