Spree::Image.class_eval do
  before_save :compose_s3_slug
  
  has_attached_file :attachment,
                    bucket:          'porthos',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    path:            'public/inventory/:master_sku/:style-:s3_slug-:image_ordinal.:extension',
                    storage:         :s3,
                    styles:          { mini: '48x48>', small: '100x100>', product: '240x240>', large: '500x500>' },
                    s3_credentials:  { access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] },
                    s3_region:       'ap-southeast-1',
                    s3_host_name:    's3-ap-southeast-1.amazonaws.com'
                    
                    
                    
  
  
  [:image_ordinal, :s3_slug, :master_sku].each do |path_facet|
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
    def compose_s3_slug
      return unless new_record?
      puts "\n\n\nCalled method: speak Paperclip Options: #{Paperclip.options.inspect}"
      puts "attachment.original_filename: #{attachment.original_filename}"
    end
    
    def image_ordinal
      position
    end
  
end