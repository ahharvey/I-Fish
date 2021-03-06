# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Rails::Helper
  #include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  #storage :file
  if Rails.env.development? || Rails.env.test?
    storage = :file
  else
    storage = :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
#    "/assets/fallback/" + [version_name, "default_avatar.png"].compact.join('_')
    #ActionController::Base.helpers.asset_path("fallback/" + [version_name, "large_default_avatar.png"].compact.join('_'))
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default_avatar.png"].compact.join('_'))
  end


  version :large do
    resize_to_limit(600, 600)
  end

  version :thumb do
    process :crop
    resize_to_fill(100, 100)
  end

#  def crop
#    if model.crop_x.present?
#      resize_to_limit(600, 600)
#      manipulate! do |img|
#        x = model.crop_x.to_i
#        y = model.crop_y.to_i
#        w = model.crop_w.to_i
#        h = model.crop_h.to_i
#        img.crop!(x, y, w, h)
#      end
#    end
#  end


  # modifies crop for minimagick
  def crop
    if model.crop_x.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        x = model.crop_x
        y = model.crop_y
        w = model.crop_w
        h = model.crop_h

        #size = w << 'x' << h
        #offset = '+' << x << '+' << y

        #img.crop("#{size}#{offset}") # Doesn't return an image...
        img.crop "#{w}x#{h}+#{x}+#{y}"
        img = yield(img) if block_given?
        img # ...so needs to be called

      end
    end

  end

  def extension_white_list
    %w(jpg jpeg gif png JPG JPEG PNG GIF)
  end

end
