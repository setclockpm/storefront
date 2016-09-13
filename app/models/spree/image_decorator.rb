Spree::Image.class_eval do
  
  has_attached_file :attachment,
                    bucket:          'porthos',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    path:            'public/inventory/:master_sku/:style-:s3_slug-:image_ordinal.:image_file_extension',
                    storage:         :s3,
                    styles:          { thumb: '48x48>', preview: '350x700>', product: '1024x768>', lightbox: '600x600>' },
                    s3_credentials:  { access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] },
                    s3_protocol:     "https",
                    s3_region:       'ap-southeast-1',
                    s3_host_name:    's3-ap-southeast-1.amazonaws.com'
                    
                    
                    
  
  
  [:image_ordinal, :s3_slug, :master_sku, :image_file_extension].each do |path_facet|
    Paperclip.interpolates path_facet do |attachment, style|
      attachment.instance.send(path_facet)
    end
  end
  
  
  def s3_slug
    viewable.s3_slug
  end
  
  def master_sku
    return viewable.sku if viewable.is_a?(Spree::Product)
    return viewable.product.sku if viewable.is_a?(Spree::Variant)
    "unknown viewable"
  end
  
  
  private
    def image_file_extension
      return 'jpg' if Paperclip::Interpolations.extension(attachment, Paperclip::Interpolations.style(attachment, nil)).blank?
      Paperclip::Interpolations.extension(attachment, Paperclip::Interpolations.style(attachment, nil))
    end
    
    def image_ordinal
      position
    end
  
end