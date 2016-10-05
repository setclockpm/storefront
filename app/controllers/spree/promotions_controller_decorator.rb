Spree::Admin::PromotionsController.class_eval do
  
  def showcase
    @showcase_items = ShowcaseItem.all
  end
  
end