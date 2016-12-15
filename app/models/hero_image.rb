class HeroImage < Spree::Asset
  has_one :image, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  
  validate :storefront_gallery_within_capacity
  
  
  private
    def storefront_gallery_within_capacity
      HeroImage.storefront_photos.size <= 6
    end
  
end
