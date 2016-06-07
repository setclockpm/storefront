Spree::Variant.class_eval do
  
  class << self
    def find_by_master_sku(master_sku, sku)
      puts "\n About to try retrieval by sku: #{sku} | sku =~ /ALL|GRP/ -> #{sku =~ /ALL|GRP/i}"
      return unless sku =~ /ALL|GRP/i
      # Only retrieving by master SKU if filename contains 'ALL' or 'GRP'
      @variant = Spree::Variant.find_by(sku: master_sku) 
    end
  end
  
  def s3_slug
    x = sku.split("\s")
    x.shift
    slug = x.join('-')
    # Split on \s join all but first index of array with a hyphen (-)
    self.is_master? ? "ALL" : slug 
  end
  
  def primary_image
    images.find_by(position: 1)
  end
  
  def primary_thumbnail_url
    primary_image.attachment.url(:mini)
  end
  
end