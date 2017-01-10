class CatalogPage < ActiveRecord::Base
  acts_as_list
  has_attached_file :image,
                    bucket:          'porthos',
                    # convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :medium,
                    path:            ":rails_root/public/assets/catalog/:attachment/:id/:style/:basename.:extension",
                    storage:         :s3,
                    styles:          { small: '160x240>', medium: '768x1024>', large: '1536x2048>', thumb: '80x120>' },
                    s3_credentials:  { access_key_id: Rails.application.secrets.aws_access_key_id, secret_access_key: Rails.application.secrets.aws_secret_access_key },
                    s3_protocol:     "https",
                    s3_region:       'ap-southeast-1',
                    s3_host_name:    's3-ap-southeast-1.amazonaws.com',
                    url:             "/system/:class/catalog/:id/:style/:basename.:extension"

  validates_attachment :image, presence: true, content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }


end
