Spree::Product.class_eval do
  validate :max_three_showcased
  
  def self.showcased_items
    where('showcased')
  end
  
  
  def lifestyle_shot?
    master_images.any?
  end
  
  def collection_image
    master_images.first if master_images.any?
  end
  
  
  private
    def max_three_showcased
      errors.add(:base, "Only up to 3 showcased products are allowed") if Spree::Product.showcased_items.size >= 3
    end
  
end
