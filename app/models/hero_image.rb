class HeroImage < Spree::Asset
  
  has_attached_file :attachment,
                    bucket:          'porthos',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    path:            'public/inventory/:master_sku/:style-:s3_slug-:image_ordinal.:image_file_extension',
                    storage:         :s3,
                    styles:          { small: '240x160>', preview: '480x360>', product: '1024x768>', large: '2048x1536>', lightbox: '800x600>' },
                    s3_credentials:  { access_key_id: Rails.application.secrets.aws_access_key_id, secret_access_key: Rails.application.secrets.aws_secret_access_key },
                    s3_protocol:     "https",
                    s3_region:       'ap-southeast-1',
                    s3_host_name:    's3-ap-southeast-1.amazonaws.com'
                    
  
  
  
  private
    def storefront_gallery_within_capacity
      HeroImage.storefront_photos.size <= 6
    end
  
end
