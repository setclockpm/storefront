Spree::Variant.class_eval do
  
  class << self
    def find_by_master_sku(master_sku, sku)
      puts "\n About to try retrieval by sku: #{sku} | sku =~ /ALL|GRP/ -> #{sku =~ /ALL|GRP/i}"
      return unless sku.match(/ALL|GRP/i)
      # Only retrieving by master SKU if filename contains 'ALL' or 'GRP'
      puts " /ALL|GRP/ pattern found, attempting to lookup variant by master sku: #{master_sku}."
      @variant = Spree::Variant.find_by(sku: master_sku) 
    end
  end
  
  
  def build_image_from_path(path, image_alt=nil)
    self.images.build(attachment: File.open(path, 'rb'), alt: image_alt)
    # @image        = @variant.images.new(attachment: File.open(@path_to_raw_image, 'rb'), alt: image_alt)
  end
  
  def s3_slug
    x = sku.split("\s")
    x.shift
    slug = x.join('-')
    # Split on \s join all but first index of array with a hyphen (-)
    self.is_master? ? "ALL" : slug 
  end
  
  def primary_image
    puts "\n Variant: #{id}-#{name}"
    images.find_by(position: 1)
  end
  
  def primary_thumbnail_url
    primary_image.attachment.url(:mini) if primary_image
  end
  
  def update_stock_count(qty)
    update_main_location_stock_count(qty)
  end
  
  
  
  private
    
    def update_main_location_stock_count(qty)
      main_location_stock_item = self.stock_items.find_by(stock_location_id: 1)
      puts "^--- Updating variant (#{sku}) count from #{main_location_stock_item.count_on_hand} to #{qty} ---^"
      main_location_stock_item.update_count(qty)
    end
  
end