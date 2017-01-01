Spree::Image.class_eval do
  
  has_attached_file :attachment,
                    bucket:          'porthos',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    path:            'public/inventory/:master_sku/:style-:s3_slug-:id.:image_file_extension',
                    storage:         :s3,
                    styles:          { mini: '48x48>', small: '240x160>', preview: '480x320!', product: '1600x1600', large: '1920x1440>', lightbox: '800x800>' },
                    s3_credentials:  { access_key_id: Rails.application.secrets.aws_access_key_id, secret_access_key: Rails.application.secrets.aws_secret_access_key },
                    s3_protocol:     "https",
                    s3_region:       'ap-southeast-1',
                    s3_host_name:    's3-ap-southeast-1.amazonaws.com'
  
  
  [:s3_slug, :master_sku, :image_file_extension].each do |path_facet|
    Paperclip.interpolates path_facet do |attachment, style|
      attachment.instance.send(path_facet)
    end
  end
  
  
  def s3_slug
    viewable.s3_slug if viewable
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
  
end