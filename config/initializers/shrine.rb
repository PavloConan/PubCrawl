# frozen_string_literal: true

require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/memory"
require "shrine/storage/s3"

Shrine.storages = if Rails.env.test?
                    {
                      cache: Shrine::Storage::Memory.new,
                      store: Shrine::Storage::Memory.new
                    }
                  elsif Rails.env.production? || Rails.env.staging_heroku?
                    s3_options = {
                      access_key_id:     Rails.application.credentials[:s3_access_key_id],
                      secret_access_key: Rails.application.credentials[:s3_secret_access_key],
                      region:            Rails.application.credentials[:s3_region],
                      bucket:            Rails.application.credentials[:s3_bucket],
                    }

                    {
                      cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
                      store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
                    }
                  else
                    {
                      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
                      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
                    }
                  end

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type, analyzer: :mime_types
