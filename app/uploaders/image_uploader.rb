# frozen_string_literal: true

class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size  5.megabytes
    validate_mime_type %w[image/jpeg image/jpg image/png image/heic image/heif image/svg+xml image/webp]
  end
end