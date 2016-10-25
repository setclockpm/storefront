Spree::Admin::PromotionsController.class_eval do
  
  def showcase
    @hero_images = HeroImage.all
  end
  
end