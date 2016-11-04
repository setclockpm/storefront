Spree::Variant.class_eval do
  MAIN_LOCATION = "Main Location"
  attr_reader :collection_image
  
  class << self
    def find_by_master_sku(master_sku, sku)
      puts "\n About to try retrieval by sku: #{sku} | sku =~ /ALL|GRP/ -> #{sku =~ /ALL|GRP/i}"
      return unless sku.match(/ALL|GRP/i)
      # Only retrieving by master SKU if filename contains 'ALL' or 'GRP'
      puts " /ALL|GRP/ pattern found, attempting to lookup variant by master sku: #{master_sku}."
      @variant = Spree::Variant.find_by(sku: master_sku) 
    end
    
    def find_those_having_master_images
      swhere(is_master: true).joins(:images).all
    end
    
  end
  
  
  def build_image_from_path(path, image_alt=nil)
    self.images.build(attachment: File.open(path, 'rb'), alt: image_alt)
    # @image        = @variant.images.new(attachment: File.open(@path_to_raw_image, 'rb'), alt: image_alt)
  end
  
  def collection_image
    if master_images
      @collection_image = master_images.first
    end
  end
  
  def dimensions
    return unless height && width && depth
    "#{height} x #{width} x #{depth}"
  end
  
  def master_images
    return unless is_master?
    return images if images.any?
  end
  
  def options_text
    values = self.option_values.sort do |a, b|
      a.option_type.position <=> b.option_type.position
    end

    values.to_a.map! do |ov|
      "#{ov.presentation}"
    end
    puts "\nvalues before inspect: #{values.inspect}\n"
    values.to_sentence({ words_connector: ", ", two_words_connector: ", " })
  end
  
  
  def primary_image
    puts "\n Variant: #{id}-#{name}"
    images.find_by(position: 1)
  end
  
  def primary_thumbnail_url
    primary_image.attachment.url(:mini) if primary_image
  end
  
  def s3_slug
    x = sku.split("\s")
    x.shift
    slug = x.join('-')
    # Split on \s join all but first index of array with a hyphen (-)
    self.is_master? ? "ALL" : slug 
  end
  
  def update_stock_count(qty)
    @location = Spree::StockLocation.find_by_admin_name(MAIN_LOCATION)
    update_main_location_stock_count(qty)
  end
  
  
  
  
  private
    
    def update_main_location_stock_count(qty)
      main_location_stock_item = self.stock_items.find_by(stock_location_id: @location.id)
      puts "^--- Updating variant (#{sku}) count from #{main_location_stock_item.count_on_hand} to #{qty} ---^"
      main_location_stock_item.update_count(qty)
    end
  
end