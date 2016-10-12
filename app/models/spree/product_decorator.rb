Spree::Product.class_eval do
  
  
  def lifestyle_shot?
    master_images.any?
  end
  
end
