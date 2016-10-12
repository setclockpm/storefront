Spree::Product.class_eval do
  
  
  def lifestyle_shot?
    master_images.any?
  end
  
  def collection_image
    master_images.first if master_images.any?
  end
  
end
