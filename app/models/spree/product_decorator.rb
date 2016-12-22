
Spree::Product.class_eval do
  ALLOWED_SHOWCASE_ITEMS = 3 unless const_defined?(:ALLOWED_SHOWCASE_ITEMS)

  validate :max_showcased_items_count_not_exceeded
  
  # Class methods
  def self.showcased_items
    where('showcased')
  end
  
  def self.allowed_showcase_items
    ALLOWED_SHOWCASE_ITEMS
  end
  
  
  # Instance methods
  def lifestyle_shot?
    master_images.any?
  end
  
  def collection_image
    master_images.first if master_images.any?
  end
  
  
  
  private
    
    def max_showcased_items_count_not_exceeded
      current_showcased_items = self.class.showcased_items
      return if current_showcased_items.size < ALLOWED_SHOWCASE_ITEMS
      # We're at max
      return if current_showcased_items.map(&:id).include?(id)
      # We don't count if this record is one of the showcased. (Can never increase showcase count)
      return unless attributes['showcased']
      # We don't ccre unless another record trying to becime showcased
      errors.add(:base, :too_many_showcased_items, count: ALLOWED_SHOWCASE_ITEMS)
    end
  
end
